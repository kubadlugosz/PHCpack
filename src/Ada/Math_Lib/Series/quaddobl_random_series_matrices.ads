with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with QuadDobl_Complex_Series_VecVecs;    use QuadDobl_Complex_Series_VecVecs;
with QuadDobl_Complex_Series_Matrices;
with QuadDobl_Complex_Matrix_Series;

package QuadDobl_Random_Series_Matrices is

-- DESCRIPTION :
--   Exports functions that return random power series,
--   truncated to the given degree,
--   with coefficients in double double precision,
--   in vectors of vectors and matrices.

  function Random_Series_VecVec
             ( vvfirst,vvlast,first,last,degree : integer32 ) return VecVec;

  -- DESCRIPTION :
  --   Returns a vector of vectors with random series of the given degree.
  --   The outer range is vvfirst..vvlast and the inner range of
  --   the vectors is first..last.

  function Random_Series_Matrix
             ( rowfirst,rowlast,columnfirst,columnlast,degree : integer32 )
             return QuadDobl_Complex_Series_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns a matrix of range(1) rowfirst..rowlast and range(2) 
  --   columnfirst..columnlast with random series of the given degree.

  function Random_Matrix_Series
             ( deg,dim,lower,upper : integer32 )
             return QuadDobl_Complex_Matrix_Series.Matrix;

  -- DESCRIPTION :
  --   Returns a random matrix series, with integer coefficients 
  --   in [lower, upper], of the given degree deg and dimension dim.
  --   The coefficients are stored in standard double precision.

  function Random_Matrix_Series
             ( deg,dim : integer32 )
             return QuadDobl_Complex_Matrix_Series.Matrix;

  -- DESCRIPTION :
  --   Returns a random matrix series, with random complex coefficients
  --   of modulus one, of the given degree deg and dimension dim.
  --   The coefficients are stored in standard double precision.

end QuadDobl_Random_Series_Matrices;
