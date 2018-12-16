with text_io;                           use text_io;
with QuadDobl_Monomial_Vectors;         use QuadDobl_Monomial_Vectors;

package QuadDobl_Monomial_Vectors_io is

-- DESCRIPTION :
--   A basic output procedure is defined by this package.

  procedure put ( v : in Monomial_Vector );
  procedure put ( file : in file_type; v : in Monomial_Vector );
  procedure put ( v : in Link_to_Monomial_Vector );
  procedure put ( file : in file_type; v : in Link_to_Monomial_Vector );

  -- DESCRIPTION :
  --   Writes the contents of the monomial vector to standard output
  --   or to file.

end QuadDobl_Monomial_Vectors_io;
