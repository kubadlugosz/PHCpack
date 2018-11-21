with Standard_Natural_Vectors;
with Standard_Complex_Series_Functions;
with DoblDobl_Complex_Series_Functions;
with QuadDobl_Complex_Series_Functions;
with Complex_Series_and_Polynomials;

package body Series_and_Homotopies is

  function Create ( h : in Standard_Complex_Poly_Systems.Poly_Sys;
                    idx : in integer32; verbose : boolean := false )
                  return Standard_CSeries_Poly_Systems.Poly_Sys is

    res : constant Standard_CSeries_Poly_Systems.Poly_Sys
        := Complex_Series_and_Polynomials.System_to_Series_System
             (h,idx,verbose);

  begin
    return res;
  end Create;

  function Create ( h : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                    idx : in integer32; verbose : boolean := false )
                  return DoblDobl_CSeries_Poly_Systems.Poly_Sys is

    res : constant DoblDobl_CSeries_Poly_Systems.Poly_Sys
        := Complex_Series_and_Polynomials.System_to_Series_System
             (h,idx,verbose);

  begin
    return res;
  end Create;

  function Create ( h : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                    idx : in integer32; verbose : boolean := false )
                  return QuadDobl_CSeries_Poly_Systems.Poly_Sys is

    res : constant QuadDobl_CSeries_Poly_Systems.Poly_Sys
        := Complex_Series_and_Polynomials.System_to_Series_System
             (h,idx,verbose);

  begin
    return res;
  end Create;

  function Eval ( p : Standard_CSeries_Polynomials.Poly;
                  t : double_float )
                return Standard_Complex_Polynomials.Poly is

    res : Standard_Complex_Polynomials.Poly
        := Standard_Complex_Polynomials.Null_Poly;

    procedure Eval_Term ( trm : in Standard_CSeries_Polynomials.Term;
                          cont : out boolean ) is

      rt : Standard_Complex_Polynomials.Term;

    begin
      rt.cf := Standard_Complex_Series_Functions.Eval(trm.cf,t);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      Standard_Complex_Polynomials.Add(res,rt);
      Standard_Complex_Polynomials.Clear(rt);
      cont := true;
    end Eval_Term;
    procedure Eval_Terms is
      new Standard_CSeries_Polynomials.Visiting_Iterator(Eval_Term);

  begin
    Eval_Terms(p);
    return res;
  end Eval;

  function Eval ( p : Standard_CSeries_Polynomials.Poly;
                  t : Standard_Complex_Numbers.Complex_Number )
                return Standard_Complex_Polynomials.Poly is

    res : Standard_Complex_Polynomials.Poly
        := Standard_Complex_Polynomials.Null_Poly;

    procedure Eval_Term ( trm : in Standard_CSeries_Polynomials.Term;
                          cont : out boolean ) is

      rt : Standard_Complex_Polynomials.Term;

    begin
      rt.cf := Standard_Complex_Series_Functions.Eval(trm.cf,t);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      Standard_Complex_Polynomials.Add(res,rt);
      Standard_Complex_Polynomials.Clear(rt);
      cont := true;
    end Eval_Term;
    procedure Eval_Terms is
      new Standard_CSeries_Polynomials.Visiting_Iterator(Eval_Term);

  begin
    Eval_Terms(p);
    return res;
  end Eval;

  function Eval ( p : DoblDobl_CSeries_Polynomials.Poly;
                  t : double_double )
                return DoblDobl_Complex_Polynomials.Poly is

    res : DoblDobl_Complex_Polynomials.Poly
        := DoblDobl_Complex_Polynomials.Null_Poly;

    procedure Eval_Term ( trm : in DoblDobl_CSeries_Polynomials.Term;
                          cont : out boolean ) is

      rt : DoblDobl_Complex_Polynomials.Term;

    begin
      rt.cf := DoblDobl_Complex_Series_Functions.Eval(trm.cf,t);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      DoblDobl_Complex_Polynomials.Add(res,rt);
      DoblDobl_Complex_Polynomials.Clear(rt);
      cont := true;
    end Eval_Term;
    procedure Eval_Terms is
      new DoblDobl_CSeries_Polynomials.Visiting_Iterator(Eval_Term);

  begin
    Eval_Terms(p);
    return res;
  end Eval;

  function Eval ( p : DoblDobl_CSeries_Polynomials.Poly;
                  t : DoblDobl_Complex_Numbers.Complex_Number )
                return DoblDobl_Complex_Polynomials.Poly is

    res : DoblDobl_Complex_Polynomials.Poly
        := DoblDobl_Complex_Polynomials.Null_Poly;

    procedure Eval_Term ( trm : in DoblDobl_CSeries_Polynomials.Term;
                          cont : out boolean ) is

      rt : DoblDobl_Complex_Polynomials.Term;

    begin
      rt.cf := DoblDobl_Complex_Series_Functions.Eval(trm.cf,t);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      DoblDobl_Complex_Polynomials.Add(res,rt);
      DoblDobl_Complex_Polynomials.Clear(rt);
      cont := true;
    end Eval_Term;
    procedure Eval_Terms is
      new DoblDobl_CSeries_Polynomials.Visiting_Iterator(Eval_Term);

  begin
    Eval_Terms(p);
    return res;
  end Eval;

  function Eval ( p : QuadDobl_CSeries_Polynomials.Poly;
                  t : Quad_double )
                return QuadDobl_Complex_Polynomials.Poly is

    res : QuadDobl_Complex_Polynomials.Poly
        := QuadDobl_Complex_Polynomials.Null_Poly;

    procedure Eval_Term ( trm : in QuadDobl_CSeries_Polynomials.Term;
                          cont : out boolean ) is

      rt : QuadDobl_Complex_Polynomials.Term;

    begin
      rt.cf := QuadDobl_Complex_Series_Functions.Eval(trm.cf,t);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      QuadDobl_Complex_Polynomials.Add(res,rt);
      QuadDobl_Complex_Polynomials.Clear(rt);
      cont := true;
    end Eval_Term;
    procedure Eval_Terms is
      new QuadDobl_CSeries_Polynomials.Visiting_Iterator(Eval_Term);

  begin
    Eval_Terms(p);
    return res;
  end Eval;

  function Eval ( p : QuadDobl_CSeries_Polynomials.Poly;
                  t : QuadDobl_Complex_Numbers.Complex_Number )
                return QuadDobl_Complex_Polynomials.Poly is

    res : QuadDobl_Complex_Polynomials.Poly
        := QuadDobl_Complex_Polynomials.Null_Poly;

    procedure Eval_Term ( trm : in QuadDobl_CSeries_Polynomials.Term;
                          cont : out boolean ) is

      rt : QuadDobl_Complex_Polynomials.Term;

    begin
      rt.cf := QuadDobl_Complex_Series_Functions.Eval(trm.cf,t);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      QuadDobl_Complex_Polynomials.Add(res,rt);
      QuadDobl_Complex_Polynomials.Clear(rt);
      cont := true;
    end Eval_Term;
    procedure Eval_Terms is
      new QuadDobl_CSeries_Polynomials.Visiting_Iterator(Eval_Term);

  begin
    Eval_Terms(p);
    return res;
  end Eval;

  function Eval ( h : Standard_CSeries_Poly_Systems.Poly_Sys;
                  t : double_float )
                return Standard_Complex_Poly_Systems.Poly_Sys is

    res : Standard_Complex_Poly_Systems.Poly_Sys(h'range);

  begin
    for i in res'range loop
      res(i) := Eval(h(i),t);
    end loop;
    return res;
  end Eval;

  function Eval ( h : Standard_CSeries_Poly_Systems.Poly_Sys;
                  t : Standard_Complex_Numbers.Complex_Number )
                return Standard_Complex_Poly_Systems.Poly_Sys is

    res : Standard_Complex_Poly_Systems.Poly_Sys(h'range);

  begin
    for i in res'range loop
      res(i) := Eval(h(i),t);
    end loop;
    return res;
  end Eval;

  function Eval ( h : DoblDobl_CSeries_Poly_Systems.Poly_Sys;
                  t : double_double )
                return DoblDobl_Complex_Poly_Systems.Poly_Sys is

    res : DoblDobl_Complex_Poly_Systems.Poly_Sys(h'range);

  begin
    for i in res'range loop
      res(i) := Eval(h(i),t);
    end loop;
    return res;
  end Eval;

  function Eval ( h : DoblDobl_CSeries_Poly_Systems.Poly_Sys;
                  t : DoblDobl_Complex_Numbers.Complex_Number )
                return DoblDobl_Complex_Poly_Systems.Poly_Sys is

    res : DoblDobl_Complex_Poly_Systems.Poly_Sys(h'range);

  begin
    for i in res'range loop
      res(i) := Eval(h(i),t);
    end loop;
    return res;
  end Eval;

  function Eval ( h : QuadDobl_CSeries_Poly_Systems.Poly_Sys;
                  t : quad_double )
                return QuadDobl_Complex_Poly_Systems.Poly_Sys is

    res : QuadDobl_Complex_Poly_Systems.Poly_Sys(h'range);

  begin
    for i in res'range loop
      res(i) := Eval(h(i),t);
    end loop;
    return res;
  end Eval;

  function Eval ( h : QuadDobl_CSeries_Poly_Systems.Poly_Sys;
                  t : QuadDobl_Complex_Numbers.Complex_Number )
                return QuadDobl_Complex_Poly_Systems.Poly_Sys is

    res : QuadDobl_Complex_Poly_Systems.Poly_Sys(h'range);

  begin
    for i in res'range loop
      res(i) := Eval(h(i),t);
    end loop;
    return res;
  end Eval;

  function Shift ( p : Standard_CSeries_Polynomials.Poly;
                   c : double_float )
                 return Standard_CSeries_Polynomials.Poly is

    res : Standard_CSeries_Polynomials.Poly
        := Standard_CSeries_Polynomials.Null_Poly;

    procedure Shift_Term ( trm : in Standard_CSeries_Polynomials.Term;
                           cont : out boolean ) is

      rt : Standard_CSeries_Polynomials.Term;

    begin
      rt.cf := Standard_Complex_Series_Functions.Shift(trm.cf,c);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      Standard_CSeries_Polynomials.Add(res,rt);
      Standard_CSeries_Polynomials.Clear(rt);
      cont := true;
    end Shift_Term;
    procedure Shift_Terms is
      new Standard_CSeries_Polynomials.Visiting_Iterator(Shift_Term);

  begin
    Shift_Terms(p);
    return res;
  end Shift;

  function Shift ( p : Standard_CSeries_Polynomials.Poly;
                   c : Standard_Complex_Numbers.Complex_Number )
                 return Standard_CSeries_Polynomials.Poly is

    res : Standard_CSeries_Polynomials.Poly
        := Standard_CSeries_Polynomials.Null_Poly;

    procedure Shift_Term ( trm : in Standard_CSeries_Polynomials.Term;
                           cont : out boolean ) is

      rt : Standard_CSeries_Polynomials.Term;

    begin
      rt.cf := Standard_Complex_Series_Functions.Shift(trm.cf,c);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      Standard_CSeries_Polynomials.Add(res,rt);
      Standard_CSeries_Polynomials.Clear(rt);
      cont := true;
    end Shift_Term;
    procedure Shift_Terms is
      new Standard_CSeries_Polynomials.Visiting_Iterator(Shift_Term);

  begin
    Shift_Terms(p);
    return res;
  end Shift;

  function Shift ( p : DoblDobl_CSeries_Polynomials.Poly;
                   c : double_double )
                 return DoblDobl_CSeries_Polynomials.Poly is

    res : DoblDobl_CSeries_Polynomials.Poly
        := DoblDobl_CSeries_Polynomials.Null_Poly;

    procedure Shift_Term ( trm : in DoblDobl_CSeries_Polynomials.Term;
                           cont : out boolean ) is

      rt : DoblDobl_CSeries_Polynomials.Term;

    begin
      rt.cf := DoblDobl_Complex_Series_Functions.Shift(trm.cf,c);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      DoblDobl_CSeries_Polynomials.Add(res,rt);
      DoblDobl_CSeries_Polynomials.Clear(rt);
      cont := true;
    end Shift_Term;
    procedure Shift_Terms is
      new DoblDobl_CSeries_Polynomials.Visiting_Iterator(Shift_Term);

  begin
    Shift_Terms(p);
    return res;
  end Shift;

  function Shift ( p : DoblDobl_CSeries_Polynomials.Poly;
                   c : DoblDobl_Complex_Numbers.Complex_Number )
                 return DoblDobl_CSeries_Polynomials.Poly is

    res : DoblDobl_CSeries_Polynomials.Poly
        := DoblDobl_CSeries_Polynomials.Null_Poly;

    procedure Shift_Term ( trm : in DoblDobl_CSeries_Polynomials.Term;
                           cont : out boolean ) is

      rt : DoblDobl_CSeries_Polynomials.Term;

    begin
      rt.cf := DoblDobl_Complex_Series_Functions.Shift(trm.cf,c);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      DoblDobl_CSeries_Polynomials.Add(res,rt);
      DoblDobl_CSeries_Polynomials.Clear(rt);
      cont := true;
    end Shift_Term;
    procedure Shift_Terms is
      new DoblDobl_CSeries_Polynomials.Visiting_Iterator(Shift_Term);

  begin
    Shift_Terms(p);
    return res;
  end Shift;

  function Shift ( p : QuadDobl_CSeries_Polynomials.Poly;
                   c : quad_double )
                 return QuadDobl_CSeries_Polynomials.Poly is

    res : QuadDobl_CSeries_Polynomials.Poly
        := QuadDobl_CSeries_Polynomials.Null_Poly;

    procedure Shift_Term ( trm : in QuadDobl_CSeries_Polynomials.Term;
                           cont : out boolean ) is

      rt : QuadDobl_CSeries_Polynomials.Term;

    begin
      rt.cf := QuadDobl_Complex_Series_Functions.Shift(trm.cf,c);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      QuadDobl_CSeries_Polynomials.Add(res,rt);
      QuadDobl_CSeries_Polynomials.Clear(rt);
      cont := true;
    end Shift_Term;
    procedure Shift_Terms is
      new QuadDobl_CSeries_Polynomials.Visiting_Iterator(Shift_Term);

  begin
    Shift_Terms(p);
    return res;
  end Shift;

  function Shift ( p : QuadDobl_CSeries_Polynomials.Poly;
                   c : QuadDobl_Complex_Numbers.Complex_Number )
                 return QuadDobl_CSeries_Polynomials.Poly is

    res : QuadDobl_CSeries_Polynomials.Poly
        := QuadDobl_CSeries_Polynomials.Null_Poly;

    procedure Shift_Term ( trm : in QuadDobl_CSeries_Polynomials.Term;
                           cont : out boolean ) is

      rt : QuadDobl_CSeries_Polynomials.Term;

    begin
      rt.cf := QuadDobl_Complex_Series_Functions.Shift(trm.cf,c);
      rt.dg := new Standard_Natural_Vectors.Vector(trm.dg'range);
      for k in rt.dg'range loop
        rt.dg(k) := trm.dg(k);
      end loop;
      QuadDobl_CSeries_Polynomials.Add(res,rt);
      QuadDobl_CSeries_Polynomials.Clear(rt);
      cont := true;
    end Shift_Term;
    procedure Shift_Terms is
      new QuadDobl_CSeries_Polynomials.Visiting_Iterator(Shift_Term);

  begin
    Shift_Terms(p);
    return res;
  end Shift;

  procedure Shift ( p : in out Standard_CSeries_Polynomials.Poly;
                    c : in double_float ) is

    res : constant Standard_CSeries_Polynomials.Poly := Shift(p,c);

  begin
    Standard_CSeries_Polynomials.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out Standard_CSeries_Polynomials.Poly;
                    c : in Standard_Complex_Numbers.Complex_Number ) is

    res : constant Standard_CSeries_Polynomials.Poly := Shift(p,c);

  begin
    Standard_CSeries_Polynomials.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out DoblDobl_CSeries_Polynomials.Poly;
                    c : in double_double ) is

    res : constant DoblDobl_CSeries_Polynomials.Poly := Shift(p,c);

  begin
    DoblDobl_CSeries_Polynomials.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out DoblDobl_CSeries_Polynomials.Poly;
                    c : in DoblDobl_Complex_Numbers.Complex_Number ) is

    res : constant DoblDobl_CSeries_Polynomials.Poly := Shift(p,c);

  begin
    DoblDobl_CSeries_Polynomials.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out QuadDobl_CSeries_Polynomials.Poly;
                    c : in quad_double ) is

    res : constant QuadDobl_CSeries_Polynomials.Poly := Shift(p,c);

  begin
    QuadDobl_CSeries_Polynomials.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out QuadDobl_CSeries_Polynomials.Poly;
                    c : in QuadDobl_Complex_Numbers.Complex_Number ) is

    res : constant QuadDobl_CSeries_Polynomials.Poly := Shift(p,c);

  begin
    QuadDobl_CSeries_Polynomials.Clear(p);
    p := res;
  end Shift;

  function Shift ( p : Standard_CSeries_Poly_Systems.Poly_Sys;
                   c : double_float )
                 return Standard_CSeries_Poly_Systems.Poly_Sys is

    res : Standard_CSeries_Poly_Systems.Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := Shift(p(i),c);
    end loop;
    return res;
  end Shift;

  function Shift ( p : Standard_CSeries_Poly_Systems.Poly_Sys;
                   c : Standard_Complex_Numbers.Complex_Number )
                 return Standard_CSeries_Poly_Systems.Poly_Sys is

    res : Standard_CSeries_Poly_Systems.Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := Shift(p(i),c);
    end loop;
    return res;
  end Shift;

  function Shift ( p : DoblDobl_CSeries_Poly_Systems.Poly_Sys;
                   c : double_double )
                 return DoblDobl_CSeries_Poly_Systems.Poly_Sys is

    res : DoblDobl_CSeries_Poly_Systems.Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := Shift(p(i),c);
    end loop;
    return res;
  end Shift;

  function Shift ( p : DoblDobl_CSeries_Poly_Systems.Poly_Sys;
                   c : DoblDobl_Complex_Numbers.Complex_Number )
                 return DoblDobl_CSeries_Poly_Systems.Poly_Sys is

    res : DoblDobl_CSeries_Poly_Systems.Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := Shift(p(i),c);
    end loop;
    return res;
  end Shift;

  function Shift ( p : QuadDobl_CSeries_Poly_Systems.Poly_Sys;
                   c : quad_double )
                 return QuadDobl_CSeries_Poly_Systems.Poly_Sys is

    res : QuadDobl_CSeries_Poly_Systems.Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := Shift(p(i),c);
    end loop;
    return res;
  end Shift;

  function Shift ( p : QuadDobl_CSeries_Poly_Systems.Poly_Sys;
                   c : QuadDobl_Complex_Numbers.Complex_Number )
                 return QuadDobl_CSeries_Poly_Systems.Poly_Sys is

    res : QuadDobl_CSeries_Poly_Systems.Poly_Sys(p'range);

  begin
    for i in p'range loop
      res(i) := Shift(p(i),c);
    end loop;
    return res;
  end Shift;

  procedure Shift ( p : in out Standard_CSeries_Poly_Systems.Poly_Sys;
                    c : in double_float ) is

    res : Standard_CSeries_Poly_Systems.Poly_Sys(p'range) := Shift(p,c);

  begin
    Standard_CSeries_Poly_Systems.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out Standard_CSeries_Poly_Systems.Poly_Sys;
                    c : in Standard_Complex_Numbers.Complex_Number ) is

    res : Standard_CSeries_Poly_Systems.Poly_Sys(p'range) := Shift(p,c);

  begin
    Standard_CSeries_Poly_Systems.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out DoblDobl_CSeries_Poly_Systems.Poly_Sys;
                    c : in double_double ) is

    res : DoblDobl_CSeries_Poly_Systems.Poly_Sys(p'range) := Shift(p,c);

  begin
    DoblDobl_CSeries_Poly_Systems.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out DoblDobl_CSeries_Poly_Systems.Poly_Sys;
                    c : in DoblDobl_Complex_Numbers.Complex_Number ) is

    res : DoblDobl_CSeries_Poly_Systems.Poly_Sys(p'range) := Shift(p,c);

  begin
    DoblDobl_CSeries_Poly_Systems.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out QuadDobl_CSeries_Poly_Systems.Poly_Sys;
                    c : in quad_double ) is

    res : QuadDobl_CSeries_Poly_Systems.Poly_Sys(p'range) := Shift(p,c);

  begin
    QuadDobl_CSeries_Poly_Systems.Clear(p);
    p := res;
  end Shift;

  procedure Shift ( p : in out QuadDobl_CSeries_Poly_Systems.Poly_Sys;
                    c : in QuadDobl_Complex_Numbers.Complex_Number ) is

    res : QuadDobl_CSeries_Poly_Systems.Poly_Sys(p'range) := Shift(p,c);

  begin
    QuadDobl_CSeries_Poly_Systems.Clear(p);
    p := res;
  end Shift;

end Series_and_Homotopies;
