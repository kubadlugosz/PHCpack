with Communications_with_User;           use Communications_with_User;
with Timing_Package;                     use Timing_Package;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Floating_Numbers_io;       use Standard_Floating_Numbers_io;
with Standard_Complex_Vectors_io;        use Standard_Complex_Vectors_io;
with Standard_Complex_Polynomials;       use Standard_Complex_Polynomials;
with Standard_Complex_Poly_Systems_io;   use Standard_Complex_Poly_Systems_io;
with Standard_Scaling;                   use Standard_Scaling;

package body Drivers_for_Scaling is

  procedure Display_Info is

    i : array(1..12) of string(1..65);

  begin
    i( 1):="By scaling the coefficients are transformed so that they  do  not";
    i( 2):="have extreme values.  The purpose is to avoid numerical problems.";
    i( 3):="  Equation scaling means that every polynomial is divided by  its";
    i( 4):="average coefficient.                                             ";
    i( 5):="  Variable scaling uses transformations like z  = (10^c)*x.   The";
    i( 6):="transformation  is  such  that  real  solutions remain real.  The";
    i( 7):="inverse  of  the  condition  number  of the linear system that is";
    i( 8):="solved to set up this transformation gives an indication  on  the";
    i( 9):="condition of the original polynomial system.                     ";
    i(10):="  Solution scaling transforms the solutions of  a  scaled  system";
    i(11):="back  into  the  original  coordinate  system.   Note that in the";
    i(12):="original coordinates, the solutions can be ill-conditioned.      ";
    for k in i'range loop
      put_line(i(k));
    end loop;
  end Display_Info;

  procedure Equation_Scaling
              ( file : in file_type; p : in out Poly_Sys ) is

    timer : Timing_Widget;

  begin
    put_line(file,"EQUATION SCALING :");
    tstart(timer);
    Scale(p);
    tstop(timer);
    new_line(file); print_times(file,timer,"Equation Scaling"); new_line(file);
  end Equation_Scaling;

  procedure Variable_Scaling
              ( file : in file_type; p : in out Poly_Sys;
                basis : out natural32; scvc : out Link_to_Vector ) is

    yn : character;
    timer : Timing_Widget;
    rcond : double_float;
    bas : constant natural32 := 10;
    dim : constant integer32
        := p'length + integer32(Number_of_Unknowns(p(p'first)));
    scalecoeff : Vector(1..dim);

  begin
    put_line(file,"EQUATION AND VARIABLE SCALING :");
    put("  Reducing the variability of coefficients ? (y/n) ");
    Ask_Yes_or_No(yn);
    tstart(timer);
    if yn = 'y' then
      put_line(file,"  Reducing the variability of coefficients.");
      scale(p,bas,true,rcond,scalecoeff);
    else
      put_line(file,"  No reduction of variability of coefficients.");
      scale(p,bas,false,rcond,scalecoeff);
    end if;
    tstop(timer);
    put("  The inverse condition is");
    put(rcond,3); put_line(".");
    put(file,"  The inverse condition is");
    put(file,rcond,3); put_line(file,".");
    basis := bas;
    scvc := new Vector'(scalecoeff);
    new_line(file); print_times(file,timer,"Variable Scaling"); new_line(file);
  end Variable_Scaling;

  procedure Write_Results ( file : in file_type; p : in Poly_Sys;
                            basis : in natural32; scvc : in Link_to_Vector ) is
  begin
    new_line(file);
    put_line(file,"THE SCALED SYSTEM :");
    new_line(file);
    put(file,p'length,Number_of_Unknowns(p(p'first)),p);
    new_line(file);
    if basis /= 0 then
      new_line(file);
      put_line(file,"SCALING COEFFICIENTS :");
      new_line(file);
      put(file,basis,1); new_line(file);
      put_line(file,scvc);
    end if;
  end Write_Results;

  procedure Driver_for_Scaling
              ( file : in file_type; p : in out Poly_Sys;
                basis : out natural32; scvc : out Link_to_Vector ) is

    ans : character;
    res_scvc : Link_to_Vector;
    bas : natural32 := 0;

  begin
    loop
      new_line;
      put_line("MENU for Scaling Polynomial Systems :");
      put_line("  0 : No Scaling       : leave the menu                    ");
      put_line("  1 : Equation Scaling : divide by average coefficient     ");
      put_line("  2 : Variable Scaling : change of variables, z = (10^c)*x ");
      put("Type 0, 1, or 2 to select scaling, or i for info : ");
      Ask_Alternative(ans,"012i");
      if ans = 'i'
       then new_line; Display_Info;
      end if;
      exit when ans /= 'i';
    end loop;
    case ans is
      when '1' => Equation_Scaling(file,p);
      when '2' => Variable_Scaling(file,p,bas,res_scvc);
      when others => null;
    end case;
    case ans is
      when '1' | '2' => Write_Results(file,p,bas,res_scvc);
      when others    => null;
    end case;
    basis := bas; scvc := res_scvc;
  end Driver_for_Scaling;

end Drivers_for_Scaling;
