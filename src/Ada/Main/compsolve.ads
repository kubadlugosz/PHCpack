with Standard_Natural_Numbers;          use Standard_Natural_Numbers;

procedure compsolve ( nt : in natural32; infilename,outfilename : in string );

-- DESCRIPTION :
--   This is the main interactive driver to compute a numerical irreducible
--   decomposition for polynomial systems in the blackbox option.

-- ON ENTRY :
--   nt             the number of tasks, if 0 then no multitasking,
--                  otherwise nt tasks will be used to track the paths;
--   infilename     the name of the input file;
--   outfilename    the name of the output file.
