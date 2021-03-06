with text_io;                            use text_io;
with Communications_with_User;           use Communications_with_User;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Complex_Poly_Systems;      use Standard_Complex_Poly_Systems;
with Standard_Complex_Poly_Systems_io;   use Standard_Complex_Poly_Systems_io;
with Standard_Complex_Prod_Systems;      use Standard_Complex_Prod_Systems;
with Standard_Complex_Solutions;         use Standard_Complex_Solutions;
with Drivers_for_Multi_Homogenization;   use Drivers_for_Multi_Homogenization;

procedure ts_drivmuho is

-- DESCRIPTION :
--   Reads a polynomial system and calls the driver.

  file : file_type;
  lp : Link_to_Poly_Sys;
  b : natural32;

begin
  get(lp);
  declare
    q : Poly_Sys(lp'range);
    rq : Prod_Sys(q'range);
    qsols : Solution_List;
  begin
    put_line("Reading the output file.");
    Read_Name_and_Create_File(file);
    Driver_for_Multi_homogenization(file,lp.all,b,q,rq,qsols);
  end;
end ts_drivmuho;
