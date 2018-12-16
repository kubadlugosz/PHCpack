with QuadDobl_Complex_Ring;
with QuadDobl_Complex_Vectors;
with QuadDobl_Complex_Matrices;
with Generic_Monomials;

package QuadDobl_Complex_Monomials is
  new Generic_Monomials(QuadDobl_Complex_Ring,
                        QuadDobl_Complex_Vectors,
                        QuadDobl_Complex_Matrices);

-- DESCRIPTION :
--   Defines monomials over the ring of quad double complex numbers.
