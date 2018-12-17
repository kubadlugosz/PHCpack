with text_io;                           use text_io;
with Communications_with_User;          use Communications_with_User;
with Standard_Natural_Numbers;          use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;       use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;       use Standard_Integer_Numbers_io;
with Standard_Complex_Numbers;
with Standard_Complex_Numbers_io;       use Standard_Complex_Numbers_io;
with Standard_Complex_Vectors;
with Standard_Random_Vectors;
with DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Numbers_io;       use DoblDobl_Complex_Numbers_io;
with DoblDobl_Complex_Vectors;
with DoblDobl_Random_Vectors;
with QuadDobl_Complex_Numbers;
with QuadDobl_Complex_Numbers_io;       use QuadDobl_Complex_Numbers_io;
with QuadDobl_Complex_Vectors;
with QuadDobl_Random_Vectors;
with Standard_Complex_Monomials;
with Standard_Complex_Monomials_io;     use Standard_Complex_Monomials_io;
with DoblDobl_Complex_Monomials;
with DoblDobl_Complex_Monomials_io;     use DoblDobl_Complex_Monomials_io;
with QuadDobl_Complex_Monomials;
with QuadDobl_Complex_Monomials_io;     use QuadDobl_Complex_Monomials_io;
with Random_Monomials;

procedure ts_monom is

-- DESCRIPTION :
--   Tests the operations on monomials.

  procedure Standard_Eval ( m : in Standard_Complex_Monomials.Monomial ) is

  -- DESCRIPTION :
  --   Evaluates m at a random vector, in double precision.

    x : constant Standard_Complex_Vectors.Vector(1..integer32(m.dim))
      := Standard_Random_Vectors.Random_Vector(1,integer32(m.dim));
    y : Standard_Complex_Numbers.Complex_Number;

  begin
    y := Standard_Complex_Monomials.Eval(m,x);
    put("y : "); put(y); new_line;
  end Standard_Eval;

  procedure DoblDobl_Eval ( m : in DoblDobl_Complex_Monomials.Monomial ) is

  -- DESCRIPTION :
  --   Evaluates m at a random vector, in double double precision.

    x : constant DoblDobl_Complex_Vectors.Vector(1..integer32(m.dim))
      := DoblDobl_Random_Vectors.Random_Vector(1,integer32(m.dim));
    y : DoblDobl_Complex_Numbers.Complex_Number;

  begin
    y := DoblDobl_Complex_Monomials.Eval(m,x);
    put("y : "); put(y); new_line;
  end DoblDobl_Eval;

  procedure QuadDobl_Eval ( m : in QuadDobl_Complex_Monomials.Monomial ) is

  -- DESCRIPTION :
  --   Evaluates m at a random vector, in quad double precision.

    x : constant QuadDobl_Complex_Vectors.Vector(1..integer32(m.dim))
      := QuadDobl_Random_Vectors.Random_Vector(1,integer32(m.dim));
    y : QuadDobl_Complex_Numbers.Complex_Number;

  begin
    y := QuadDobl_Complex_Monomials.Eval(m,x);
    put("y : "); put(y); new_line;
  end QuadDobl_Eval;

  procedure Standard_Test is

  -- DESCRIPTION :
  --   Prompts for dimension, largest exponent, and then generates
  --   a random monomial with coefficient in standard double precision.

    dim : integer32 := 0;
    expmax : natural32 := 0;
    m : Standard_Complex_Monomials.Monomial;

  begin
    put_line("Testing monomial operations in double precision ...");
    put("Give the dimension : "); get(dim);
    put("Give the largest exponent : "); get(expmax);
    m := Random_Monomials.Standard_Random_Monomial(dim,expmax);
    put_line("A random monomial :"); put(m);
    Standard_Eval(m);
  end Standard_Test;

  procedure DoblDobl_Test is

  -- DESCRIPTION :
  --   Prompts for dimension, largest exponent, and then generates
  --   a random monomial with coefficient in double double precision.

    dim : integer32 := 0;
    expmax : natural32 := 0;
    m : DoblDobl_Complex_Monomials.Monomial;

  begin
    put_line("Testing monomial operations in double double precision ...");
    put("Give the dimension : "); get(dim);
    put("Give the largest exponent : "); get(expmax);
    m := Random_Monomials.DoblDobl_Random_Monomial(dim,expmax);
    put_line("A random monomial :"); put(m);
    DoblDobl_Eval(m);
  end DoblDobl_Test;

  procedure QuadDobl_Test is

  -- DESCRIPTION :
  --   Prompts for dimension, largest exponent, and then generates
  --   a random monomial with coefficient in quad double precision.

    dim : integer32 := 0;
    expmax : natural32 := 0;
    m : QuadDobl_Complex_Monomials.Monomial;

  begin
    put_line("Testing monomial operations in quad double precision ...");
    put("Give the dimension : "); get(dim);
    put("Give the largest exponent : "); get(expmax);
    m := Random_Monomials.QuadDobl_Random_Monomial(dim,expmax);
    put_line("A random monomial :"); put(m);
    QuadDobl_Eval(m);
  end QuadDobl_Test;

  procedure Main is

  -- DESCRIPTION :
  --   Prompts for the precision and then lauches the test.

    ans : character;

  begin
    new_line;
    put_line("MENU to select the precision :");
    put_line("  0. double precision");
    put_line("  1. double double precision");
    put_line("  2. quad double precision");
    put("Type 0, 1, or 2 to select the precision : ");
    Ask_Alternative(ans,"012");
    new_line;
    case ans is
      when '0' => Standard_Test;
      when '1' => DoblDobl_Test;
      when '2' => QuadDobl_Test;
      when others => null;
    end case;
  end Main;

begin
  Main;
end ts_monom;
