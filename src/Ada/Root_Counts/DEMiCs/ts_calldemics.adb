with text_io;                            use text_io;
with System_Call,File_Scanning;
with Communications_with_User;           use Communications_with_User;
with String_Splitters;                   use String_Splitters;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;        use Standard_Integer_Numbers_io;
with Standard_Parse_Numbers;
with Characters_and_Numbers;
with Standard_Random_Numbers;
with Lists_of_Integer_Vectors;           use Lists_of_Integer_Vectors;
with Arrays_of_Integer_Vector_Lists;
with Arrays_of_Integer_Vector_Lists_io;  use Arrays_of_Integer_Vector_Lists_io;
with Standard_Complex_Poly_Systems;
with Standard_Complex_Poly_Systems_io;   use Standard_Complex_Poly_Systems_io;
with Supports_of_Polynomial_Systems;

procedure ts_calldemics is

-- DESCRIPTION :
--   This basic file based interface to DEMiCs
--   assumes the executable is available as /tmp/demics.

  function Random_Name ( prefix : string ) return string is

  -- DESCRIPTION :
  --   Returns the prefix string followed by a random 8-digit integer.

    nbr : constant integer32
        := Standard_Random_Numbers.Random(10_000_000,99_999_999);

  begin
    return prefix & Characters_and_Numbers.Convert(nbr);
  end Random_Name;

  procedure Prepare_Input
              ( p : in Standard_Complex_Poly_Systems.Poly_Sys;
                rndname : out Link_to_String;
                verbose : in boolean := true ) is

  -- DESCRIPTION :
  --   Prepares the input file for the polynomial system p,
  --   extracting the supports.

  -- ON ENTRY :
  --   p        a polynomial system;
  --   verbose  flag to indicate if extra output is wanted.

  -- ON RETURN :
  --   rndname  randomly generated name of the input file.

    sup : Arrays_of_Integer_Vector_Lists.Array_of_Lists(p'range)
        := Supports_of_Polynomial_Systems.Create(p);
    file : file_type;
    filename : constant string := Random_Name("/tmp/demics_input");

  begin
    if verbose then
      put_line("The supports : "); put(sup);
      put_line("Writing to file " & filename & " ...");
    end if;
    Create_Output_File(file,filename);
    put(file,"Dim = "); put(file,sup'last,1); new_line(file);
    put(file,"Support = "); put(file,sup'last,1); new_line(file);
    new_line(file);
    put(file,"Elem =");
    for i in sup'range loop
      put(file," ");
      put(file,Length_Of(sup(i)),1);
    end loop;
    new_line(file);
    put(file,"Type =");
    for i in sup'range loop -- just assume fully mixed ...
      put(file," 1");
    end loop;
    new_line(file);
    new_line(file);
    put(file,sup);
    close(file);
    rndname := new string'(filename);
  end Prepare_Input;

  procedure Call_DEMiCs
              ( infilename : in string;
                rndname : out Link_to_String;
                verbose : in boolean := true ) is

  -- DESCRIPTION :
  --   Calls DEMiCs on the input file with name in infilename.
  --   The name of the output file is returned in rndname.

    outfilename : constant string := Random_Name("/tmp/demics_output");
    cmd : constant string
        := "/tmp/demics -c " & infilename & " > " & outfilename;

  begin
    if verbose then
      put_line("Calling " & cmd);
    end if;
    System_Call.Call(cmd);
    rndname := new string'(outfilename);
  end Call_DEMiCS;

  procedure Process_Output
              ( filename : in string; verbose : in boolean := true ) is

  -- DESCRIPTION :
  --   Writes to screen the mixed volume on the output file
  --   in the string filename.

    file : file_type;
    banner : constant string := "Mixed Volume:";
    found : boolean;
    ch,sign : character;
    nb : natural32;
    imv : integer32 := 0;

  begin
    if verbose
     then put_line("Opening " & filename & " ...");
    end if;
    Open_Input_File(file,filename);
    File_Scanning.Scan(file,banner,found);
    if not found then
      put_line("No mixed volume computed?");
    else
      get(file,ch);
      Standard_Parse_Numbers.Skip_Spaces_and_CR(file,ch);
      Standard_Parse_Numbers.Parse(file,ch,imv,nb,sign);
      new_line;
      put("The mixed volume : "); put(imv,1); new_line;
    end if;
  end Process_Output;

  procedure Main is

  -- DESCRIPTION :
  --   Prompts the user for a polynomial system,
  --   prepares the input for demics, calls demics,
  --   and then parses the output file.

    lp : Standard_Complex_Poly_Systems.Link_to_Poly_Sys;
    iptname,optname : Link_to_String;

  begin
    new_line;
    put_line("Calling DEMiCs for mixed volume computation ...");
    new_line;
    get(lp);
    new_line;
    put_line("Preparing the input ...");
    Prepare_Input(lp.all,iptname);
    Call_DEMiCs(iptname.all,optname);
    Process_Output(optname.all);
  end Main;

begin
  Main;
end ts_calldemics;