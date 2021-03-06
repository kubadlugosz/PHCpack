with Standard_Complex_Numbers;
with Standard_Mathematical_Functions;
with Standard_Complex_Numbers_Polar;
with Standard_Complex_Algebraic_Series;

package body Standard_Complex_Series_Norms is

  function Conjugate ( s : Series ) return Series is

    res : Series(s.deg);

  begin
    for i in 0..res.deg loop
      res.cff(i) := Standard_Complex_Numbers.Conjugate(s.cff(i));
    end loop;
    return res;
  end Conjugate;

  function Conjugate ( s : Link_to_Series ) return Link_to_Series is
  begin
    if s = null then
      return s;
    else
      declare
        sco : constant Series(s.deg) := Conjugate(s.all);
        res : constant Link_to_Series := new Series'(sco);
      begin
        return res;
      end;
    end if;
  end Conjugate;

  function Norm ( s : Series ) return Series is

    c : constant Series(s.deg) := Conjugate(s);
    p : constant Series(s.deg) := c*s;
    res : Series(s.deg);

  begin
    res := Standard_Complex_Algebraic_Series.sqrt(p,0);
    return res;
  end Norm;

  procedure Normalize ( s : in out Series ) is

    ns : constant Series(s.deg) := Norm(s);

  begin
    Div(s,ns);
  end Normalize;

  function Normalize ( s : Series ) return Series is

    ns : constant Series(s.deg) := Norm(s);
    res : constant Series(s.deg) := s/ns;

  begin
    return res;
  end Normalize;

  function Max_Norm ( s : Series ) return double_float is

    res : double_float := Standard_Complex_Numbers_Polar.Radius(s.cff(0));
    rad : double_float;

  begin
    for i in 1..s.deg loop
      rad := Standard_Complex_Numbers_Polar.Radius(s.cff(i));
      if rad > res
       then res := rad;
      end if;
    end loop;
    return res;
  end Max_Norm;

  function Two_Norm ( s : Series ) return double_float is

    use Standard_Complex_Numbers;

    c : constant Series(s.deg) := Conjugate(s);
    p : constant Series(s.deg) := c*s;
    res,cff : double_float := 0.0;

  begin
    for i in 0..p.deg loop
      cff := REAL_PART(p.cff(i));
      res := res + cff*cff;
    end loop;
    return Standard_Mathematical_Functions.SQRT(res);
  end Two_Norm;

end Standard_Complex_Series_Norms;
