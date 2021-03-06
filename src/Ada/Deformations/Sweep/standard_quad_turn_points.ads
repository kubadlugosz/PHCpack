with text_io;                            use text_io;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Complex_Numbers;           use Standard_Complex_Numbers;
with Standard_Integer_Vectors;
with Standard_Floating_Vectors;
with Standard_Complex_Vectors;
with Standard_Complex_VecVecs;
with Standard_Floating_Matrices;
with Standard_Complex_Matrices;
with Standard_Floating_Poly_SysFun;
with Standard_Floating_Jaco_Matrices;
with Standard_Complex_Poly_SysFun;
with Standard_Complex_Jaco_Matrices;

package Standard_Quad_Turn_Points is

-- DESCRIPTION :
--   This package offers some basic utilities to locate quadratic
--   turning points of real polynomial systems, starting from a real
--   or a complex start solution.  Values for the numerical parameters
--   are managed by the package Standard_Quad_Parameters.
--   The code can be subdivided in four parts :
--     I. step size control and corrector routines;
--    II. computing tangents, determinants and other monitoring info;
--   III. computing quadratic turning points;
--    IV. parabolic minimization of determinants.

-- I. STEP SIZE CONTROL and CORRECTOR ROUTINES :

  procedure Set_Step_Size
               ( h : in out double_float; flag : in integer32 );

  -- DESCRIPTION :
  --   Depending on the value of the flag, the step size h is set.

  -- ON ENTRY :
  --   h         current value of the step size;
  --   flag      < 0 : first time use,
  --             = 0 : a corrector failure occurred,
  --             > 0 : number of consecutive successes.

  -- ON RETURN :
  --   h         new value for the step size, depending on flag:
  --             < 0 : h has the value of the maximal step size,
  --             = 0 : the step size is reduced,
  --             > 0 : h is enlarged provided, flag > threshold.

  procedure Step_Size_Control
               ( h : in out double_float; flag : in integer32 );
  procedure Step_Size_Control
               ( file : in file_type;
                 h : in out double_float; flag : in integer32 );

  -- DESCRIPTION :
  --   Determines the step size, either silently or writing one line to file.

  procedure Step_Size_Control 
               ( h : in out Complex_Number; flag : in integer32 );
  procedure Step_Size_Control 
               ( file : in file_type;
                 h : in out Complex_Number; flag : in integer32 );

  -- DESCRIPTION :
  --   Determines step size, encoded as a complex number.

  procedure One_Corrector_Step
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Floating_Vectors.Vector;
                 x,y : in out Standard_Floating_Vectors.Vector;
                 err,res : out double_float );
  procedure One_Corrector_Step
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Complex_Vectors.Vector;
                 x,y : in out Standard_Complex_Vectors.Vector;
                 err,res : out double_float );

  -- DESCRIPTION :
  --   Executes one corrector step on x, perpendicular to t.

  -- ON ENTRY :
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   t         current normalized tangent vector at x;
  --   x         predicted solution;
  --   y         evaluation of p at x.

  -- ON RETURN :
  --   x         updated solution;
  --   y         updated evaluation of p at y;
  --   err       magnitude of the correction;
  --   res       residual of the updated solution.

  procedure One_Corrector_Step
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 x,y : in out Standard_Floating_Vectors.Vector;
                 err,res : out double_float );
  procedure One_Corrector_Step
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 x,y : in out Standard_Floating_Vectors.Vector;
                 err,res,det : out double_float );
  procedure One_Corrector_Step
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 x,y : in out Standard_Complex_Vectors.Vector;
                 err,res : out double_float );
  procedure One_Corrector_Step
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 x,y : in out Standard_Complex_Vectors.Vector;
                 err,res,det : out double_float );

  -- DESCRIPTION :
  --   Executes one corrector step on x, for fixed continuation parameter.

  -- ON ENTRY :
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   t         current value of the continuation parameter;
  --   x         predicted solution;
  --   y         evaluation of p at x.

  -- ON RETURN :
  --   x         updated solution;
  --   y         updated evaluation of p at y;
  --   err       magnitude of the correction;
  --   res       residual of the updated solution;
  --   det       determinant of the Jacobian matrix at the updated x.

  procedure Interactive_Correct_Solution
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Floating_Vectors.Vector;
                 x : in out Standard_Floating_Vectors.Vector );
  procedure Interactive_Correct_Solution
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Complex_Vectors.Vector;
                 x : in out Standard_Complex_Vectors.Vector );

  -- DESCRIPTION :
  --   Interactive routine to correct a solution: the user can decide
  --   whether to continue the correction process or to stop it.

  -- ON ENTRY :
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   t         current normalized tangent vector at x;
  --   x         predicted solution.

  -- ON RETURN :
  --   x         updated solution.

  procedure Correct_Solution
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Floating_Vectors.Vector;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );
  procedure Correct_Solution
               ( file : in file_type;
                 p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Floating_Vectors.Vector;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );
  procedure Correct_Solution
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Complex_Vectors.Vector;
                 x : in out Standard_Complex_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );
  procedure Correct_Solution
               ( file : in file_type;
                 p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 t : in Standard_Complex_Vectors.Vector;
                 x : in out Standard_Complex_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );

  -- DESCRIPTION :
  --   Applies a number of corrector steps till the tolerance is satisfied.
  --   Writes intermediate output to screen or to file.

  -- ON ENTRY :
  --   file      must be opened for output;
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   t         current normalized tangent vector at x;
  --   x         predicted solution;
  --   tol_err   tolerance on the magnitude of the correction vector;
  --   tol_res   tolerance on the residual vector;
  --   maxit     maximal allowed number of corrector steps. 

  -- ON RETURN :
  --   x         updated solution;
  --   fail      true if failed to reach the tolerance within the
  --             allowed number of steps, or when divergence occurred;
  --   nbrit     number of corrector steps executed.

  procedure Target_Correction
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 target : in double_float;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );
  procedure Target_Correction
               ( file : in file_type;
                 p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 target : in double_float;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );
  procedure Target_Correction
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 target : in double_float;
                 x : in out Standard_Complex_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );
  procedure Target_Correction
               ( file : in file_type;
                 p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 target : in double_float;
                 x : in out Standard_Complex_Vectors.Vector;
                 tol_err,tol_res : in double_float; fail : out boolean;
                 nbrit : out natural32; maxit : in natural32 );

  -- DESCRIPTION :
  --    Corrects a regular solution after overshooting the target.

  -- ON ENTRY :
  --   file      must be opened for output;
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   t         target value for the artificial continuation parameter;
  --   x         predicted solution;
  --   tol_err   tolerance on the magnitude of the correction vector;
  --   tol_res   tolerance on the residual vector;
  --   maxit     maximal allowed number of corrector steps. 

  -- ON RETURN :
  --   x         updated solution;
  --   fail      true if failed to reach the tolerance within the
  --             allowed number of steps, or when divergence occurred;
  --   nbrit     number of corrector steps executed.

-- II. COMPUTING TANGENTS, DETERMINANTS and other MONOTORING info :

  function Inner_Product ( x,y : Standard_Complex_Vectors.Vector )
                         return Complex_Number;

  -- DESCRIPTION :
  --   Returns the inner product of x with the complex conjugate of y.

  function Determinant_after_LU
              ( A : Standard_Floating_Matrices.Matrix;
                piv : Standard_Integer_Vectors.Vector )
              return double_float;
  function Determinant_after_LU
              ( A : Standard_Complex_Matrices.Matrix;
                piv : Standard_Integer_Vectors.Vector )
              return Complex_Number;

  -- DESCRIPTION :
  --   Returns the determinant of A = LU (output of lufac),
  --   where piv stores the pivoting of the LU-factorization.

  function Maximal_Minors
              ( evjm : Standard_Floating_Matrices.Matrix )
              return Standard_Floating_Vectors.Vector;

  -- DESCRIPTION :
  --   Given the Jacobian matrix evaluated at the current solution,
  --   this function returns the determinants of all n-by-n submatrices,
  --   where n equals the number of variables (parameters excluded).
  --   The result is a vector of range 1..n+1.

  procedure Eigenvalues ( evjm : in Standard_Floating_Matrices.Matrix;
                          L : out Standard_Complex_Vectors.Vector );
  procedure Eigenvectors ( evjm : in Standard_Floating_Matrices.Matrix;
                           L : out Standard_Complex_Vectors.Vector;
                           v : out Standard_Complex_VecVecs.VecVec );

  -- DESCRIPTION :
  --   Computes eigenvalues of the first n-by-n submatrix of evjm,
  --   where n equals the number of variables (parameters excluded).
  --   The vector L on return contains the eigenvalues.
  --   Eigenvectors also returns the corresponding eigenvectors.

  function Tangent ( jm : Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                     x : Standard_Floating_Vectors.Vector )
                   return Standard_Floating_Vectors.Vector;
  function Tangent ( jm : Standard_Complex_Jaco_Matrices.Eval_Jaco_Mat;
                     x : Standard_Complex_Vectors.Vector )
                   return Standard_Complex_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns a normalized tangent vector with positive orientation in t.

  -- REQUIRED : jm'last(1) = jm'last(2) - 1; if t is the vector on return,
  --   then t = jm'last(2) and t'range = x'range.

  -- ON ENTRY :
  --   jm       Jacobi matrix of a polynomial system, ready to evaluate;
  --   x        current solution along a path.

  -- ON RETURN :
  --   a vector in the kernel of the Jacobian matrix, normalized,
  --   and with positive last component. 

  procedure Tangent_and_Determinant
               ( jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in Standard_Floating_Vectors.Vector;
                 t : out Standard_Floating_Vectors.Vector;
                 d : out double_float );
  procedure Tangent_and_Determinant
               ( jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in Standard_Complex_Vectors.Vector;
                 t : out Standard_Complex_Vectors.Vector;
                 d : out Complex_Number );

  -- DESCRIPTION :
  --   Returns in t a normalized tangent vector with positive orientation,
  --   along with the determinant of the Jacobian matrix in d.

  -- REQUIRED : jm'last(1) = jm'last(2) - 1; if t is the vector on return,
  --   then t = jm'last(2) and t'range = x'range.

  -- ON ENTRY :
  --   jm        Jacobi matrix of a polynomial system, ready to evaluate;
  --   x         current solution along a path.

  -- ON RETURN :
  --   t         a vector in the kernel of the Jacobian matrix, normalized,
  --             and with positive last component, only if d /= 0.0;
  --   d         determinant of the Jacobian matrix used to compute t;
  --             if pivoting in the Jacobian matrix turned up info /= 0,
  --             then the value for d on return will be 0.0.

  procedure Tangent_and_Minors
               ( jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in Standard_Floating_Vectors.Vector;
                 t,d : out Standard_Floating_Vectors.Vector );

  -- DESCRIPTION :
  --   Computes tangent and the maximal minors of the Jacobian matrix
  --   at the current solution vector x.

  -- REQUIRED : jm'last(1) = jm'last(2) - 1; if t is the vector on return,
  --   then t = jm'last(2) and t'range = x'range.

  -- ON ENTRY :
  --   jm        Jacobi matrix of a polynomial system, ready to evaluate;
  --   x         current solution along a path.

  -- ON RETURN :
  --   t         a vector in the kernel of the Jacobian matrix, normalized,
  --             and with positive last component;
  --   d         vector of jm'range(1), its k-th entry is the determinant 
  --             of the Jacobian matrix at x, with the k-th column omitted.

  procedure Tangent_Minors_and_Eigenvalues
               ( jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in Standard_Floating_Vectors.Vector;
                 t,d : out Standard_Floating_Vectors.Vector;
                 L : out Standard_Complex_Vectors.Vector );
  procedure Tangent_Minors_and_Eigenvectors
               ( jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in Standard_Floating_Vectors.Vector;
                 t,d : out Standard_Floating_Vectors.Vector;
                 L : out Standard_Complex_Vectors.Vector;
                 v : out Standard_Complex_VecVecs.VecVec );

  -- DESCRIPTION :
  --   Computes tangent, maximal minors, and eigenvalues of the Jacobian 
  --   matrix at the current solution vector x.

  -- REQUIRED : jm'last(1) = jm'last(2) - 1; if t is the vector on return,
  --   then t = jm'last(2) and t'range = x'range.

  -- ON ENTRY :
  --   jm        Jacobi matrix of a polynomial system, ready to evaluate;
  --   x         current solution along a path.

  -- ON RETURN :
  --   t         a vector in the kernel of the Jacobian matrix, normalized,
  --             and with positive last component;
  --   d         vector of jm'range(1), its k-th entry is the determinant 
  --             of the Jacobian matrix at x, with the k-th column omitted;
  --   L         eigenvalues of the Jacobian matrix (minus sweeping equation);
  --   v         corresponding eigenvectors.

  procedure Report_Minors_and_Eigenvectors
               ( file : in file_type;
                 m : in Standard_Floating_Vectors.Vector;
                 L : in Standard_Complex_Vectors.Vector;
                 v : in Standard_Complex_VecVecs.VecVec );

  -- DESCRIPTION :
  --   Writes minors, eigenvalues and eigenvectors to file.

-- III. COMPUTING QUADRATIC TURNING POINTS :

  procedure Seek_Turn
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 x1,t1,x2,t2 : in out Standard_Floating_Vectors.Vector;
                 step : in double_float );
  procedure Seek_Turn
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 x1,t1,x2,t2 : in out Standard_Complex_Vectors.Vector;
                 step : in Complex_Number );

  -- DESCRIPTION :
  --   Seeks to locate the turning point more accurately,
  --   with the application of a plain bisection method.

  -- ON ENTRY :
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   x1        solution before the turning point;
  --   t1        tangent vector at x1;
  --   x2        solution after the turning point;
  --   t2        tangent vector at x;
  --   step      current step size.

  -- ON RETURN :
  --   x1,x2     approximations for the turning point;
  --   t1,t2     corresponding tangent vectors at x1 and x2.

  procedure Interactive_Shoot_Turn
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 x1,t1,x2,t2 : in out Standard_Floating_Vectors.Vector;
                 step : in double_float );
  procedure Interactive_Shoot_Turn
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 x1,t1,x2,t2 : in out Standard_Complex_Vectors.Vector;
                 step : in Complex_Number );

  -- DESCRIPTION :
  --   Seeks to locate the turning point more accurately,
  --   with the application of a first-order shooting method.
  --   The user decides when to stop the shooting.

  -- ON ENTRY :
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   x1        solution before the turning point;
  --   t1        tangent vector at x1;
  --   x2        solution after the turning point;
  --   t2        tangent vector at x;
  --   step      current step size.

  -- ON RETURN :
  --   x1,x2     approximations for the turning point;
  --   t1,t2     corresponding tangent vectors at x1 and x2.

  procedure Shoot_Turn
               ( p : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Floating_Jaco_Matrices.Eval_Jaco_mat;
                 x1,t1,x2,t2 : in out Standard_Floating_Vectors.Vector;
                 step,tol_step : in double_float; max : in natural );
  procedure Shoot_Turn
               ( p : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jm : in Standard_Complex_Jaco_Matrices.Eval_Jaco_mat;
                 x1,t1,x2,t2 : in out Standard_Complex_Vectors.Vector;
                 step,tol_step : in Complex_Number; max : in natural );

  -- DESCRIPTION :
  --   Seeks to locate the turning point more accurately,
  --   with the application of a first-order shooting method.

  -- ON ENTRY :
  --   p         a polynomial system, in evaluable format;
  --   jm        Jacobi matrix of the system p, ready to evaluate;
  --   x1        solution before the turning point;
  --   t1        tangent vector at x1;
  --   x2        solution after the turning point;
  --   t2        tangent vector at x;
  --   step      current step size;
  --   tol_step  tolerance on the step size;
  --   max       maximal number of shooting times.

  -- ON RETURN :
  --   x1,x2     approximations for the turning point;
  --   t1,t2     corresponding tangent vectors at x1 and x2.

-- IV. PARABOLIC MINIMIZATION OF DETERMINANTS :

  procedure Silent_Monitor_Determinants
               ( x,y : in out Standard_Floating_Vectors.Vector;
                 i : in out integer32; t,d : in double_float;
                 crit : out natural32; z : out double_float );

  -- DESCRIPTION :
  --   Monitors three consecutive values of determinants,
  --   without intermediate output to screen.

  -- ON ENTRY :
  --   x         window of 3 consecutive values for t;
  --   y         data values corresponding to x;
  --   i         index to last element in x;
  --   t         current value of the continuation parameter;
  --   d         new incoming value for the determinant.

  -- ON RETURN :
  --   x         updated window of 3 t-values;
  --   y         updated window of data values;
  --   i         updated index in the window;
  --   crit      type of critical point:
  --               0 if no critical point,
  --               3 if change in sign of determinant is detected,
  --               4 if parabolic interpolation hints at backup;
  --   z         if crit /= 0, then z is backup value for t.
  --
  procedure Monitor_Determinants
               ( x,y : in out Standard_Floating_Vectors.Vector;
                 i : in out integer32; t,d : in double_float;
                 crit : out natural32; z : out double_float );
  procedure Monitor_Determinants
               ( file : in file_type;
                 x,y : in out Standard_Floating_Vectors.Vector;
                 i : in out integer32; t,d : in double_float;
                 crit : out natural32; z : out double_float );

  -- DESCRIPTION :
  --   Monitors three consecutive values of determinants,
  --   with intermediate output to screen or to file.

  -- ON ENTRY :
  --   file      for intermediate output if provided;
  --   x         window of 3 consecutive values for t;
  --   y         data values corresponding to x;
  --   i         index to last element in x;
  --   t         current value of the continuation parameter;
  --   d         new incoming value for the determinant.

  -- ON RETURN :
  --   x         updated window of 3 t-values;
  --   y         updated window of data values;
  --   i         updated index in the window;
  --   crit      type of critical point:
  --               0 if no critical point,
  --               3 if change in sign of determinant is detected,
  --               4 if parabolic interpolation hints at backup;
  --   z         if crit /= 0, then z is backup value for t.

  procedure Silent_Bisection_Singularity
               ( t1,t2,d1,d2 : in out double_float;
                 f : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail,critical : out boolean;
                 nit : out natural32 );

  -- DESCRIPTION :
  --   Applies the bisection method to locate a singular solution,
  --   without intermediate output to screen or to file.

  -- REQUIRED : d1*d2 < 0.

  -- ON ENTRY :
  --   t1,t2     two consecutive values for the continuation parameter;
  --   d1,d2     corresponding values for the determinant;
  --   f         polynomial system to evaluate the homotopy;          
  --   jf        Jacobi matrix of the homotopy;
  --   x         initial starting point for the solution;
  --   tol_err   tolerance for increment to update the solution;
  --   tol_res   tolerance for the residual;
  --   tol_det   tolerance for the determinant;
  --   max       maximal number of Newton iterators.

  -- ON RETURN :
  --   x         corrected solution;
  --   fail      true if desired accuracy not met within max iterations;
  --   critical  true if the determinant is less than tol_det;
  --   nit       number of iterations done on the solution.

  procedure Bisection_Singularity
               ( file : in file_type;
                 t1,t2,d1,d2 : in out double_float;
                 f : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail,critical : out boolean;
                 nit : out natural32 );

  -- DESCRIPTION :
  --   Applies the bisection method to locate a singular solution.

  -- REQUIRED : d1*d2 < 0.

  -- ON ENTRY :
  --   file      for intermediate output and diagnostics;
  --   t1,t2     two consecutive values for the continuation parameter;
  --   d1,d2     corresponding values for the determinant;
  --   f         polynomial system to evaluate the homotopy;          
  --   jf        Jacobi matrix of the homotopy;
  --   x         initial starting point for the solution;
  --   tol_err   tolerance for increment to update the solution;
  --   tol_res   tolerance for the residual;
  --   tol_det   tolerance for the determinant;
  --   max       maximal number of Newton iterators.

  -- ON RETURN :
  --   x         corrected solution;
  --   fail      true if desired accuracy not met within max iterations;
  --   critical  true if the determinant is less than tol_det;
  --   nit       number of iterations done on the solution.

  procedure Quadratic_Interpolation
               ( x,y : in Standard_Floating_Vectors.Vector;
                 p,q : out double_float );
  procedure Quadratic_Interpolation
               ( file : in file_type;
                 x,y : in Standard_Floating_Vectors.Vector;
                 p,q : out double_float );

  -- DESCRIPTION :
  --   Returns numerator p and denominator q of the critical value
  --   of the parabola passing through the data points (x,y).
  --   The value of the critical t is p/q.

  procedure Silent_Parabolic_Minimization
               ( vt,dt : in Standard_Floating_Vectors.Vector;
                 zt : in double_float;
                 f : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail,critical : out boolean;
                 nit : out natural32 );

  -- DESCRIPTION :
  --   Backup to a suspected critical value of the continuation parameter,
  --   without intermediate output to screen or to file.

  -- ON ENTRY :
  --   vt        3 consecutive values of the continuation parameter;
  --   dt        values of determinants, corresponding to the vt's;
  --   zt        suspected critical value;
  --   f         polynomial system to evaluate the homotopy;          
  --   jf        Jacobi matrix of the homotopy;
  --   x         initial starting point for the solution;
  --   tol_err   tolerance for increment to update the solution;
  --   tol_res   tolerance for the residual;
  --   tol_det   tolerance for the determinant;
  --   max       maximal number of Newton iterators.

  -- ON RETURN :
  --   x         corrected solution;
  --   fail      true if desired accuracy not met within max iterations;
  --   critical  true if the determinant is less than tol_det;
  --   nit       number of iterations done on the solution.

  procedure Parabolic_Minimization
               ( file : in file_type;
                 vt,dt : in Standard_Floating_Vectors.Vector;
                 zt : in double_float;
                 f : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Floating_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail,critical : out boolean;
                 nit : out natural32 );

  -- DESCRIPTION :
  --   Backup to a suspected critical value of the continuation parameter.

  -- ON ENTRY :
  --   file      for intermediate output and diagnostics;
  --   vt        3 consecutive values of the continuation parameter;
  --   dt        values of determinants, corresponding to the vt's;
  --   zt        suspected critical value;
  --   f         polynomial system to evaluate the homotopy;          
  --   jf        Jacobi matrix of the homotopy;
  --   x         initial starting point for the solution;
  --   tol_err   tolerance for increment to update the solution;
  --   tol_res   tolerance for the residual;
  --   tol_det   tolerance for the determinant;
  --   max       maximal number of Newton iterators.

  -- ON RETURN :
  --   x         corrected solution;
  --   fail      true if desired accuracy not met within max iterations;
  --   critical  true if the determinant is less than tol_det;
  --   nit       number of iterations done on the solution.

  procedure Silent_Monitor_Singularity
               ( nd : in double_float;
                 vt,dt : in out Standard_Floating_Vectors.Vector;
                 i : in out integer32;
                 f : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Floating_Vectors.Vector;
                 px,pt,dx : in Standard_Floating_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail : out boolean;
                 nit,crtp : out natural32 );
  procedure Silent_Monitor_Singularity
               ( nd : in Complex_Number;
                 vt,dt : in out Standard_Floating_Vectors.Vector;
                 i : in out integer32;
                 f : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Complex_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Complex_Vectors.Vector;
                 px,pt,dx : in Standard_Complex_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail : out boolean;
                 nit,crtp : out natural32 );

  -- DESCRIPTION :
  --   Monitors determinant, orientation of tangent, and consecutive
  --   values of determinant for possible singularities,
  --   without extra output to file or screen.

  -- ON ENTRY :
  --   nd        new value for determinant for t = x(x'last);
  --   vt        3 consecutive values of the continuation parameter;
  --   dt        values of determinants, corresponding to the vt's;
  --   i         index to last element in vt;
  --   f         polynomial system to evaluate the homotopy;          
  --   jf        Jacobi matrix of the homotopy;
  --   x         initial starting point for the solution;
  --   px        previous value along the solution path;
  --   pt        previous tangent vector;
  --   dx        current tangent vector;
  --   tol_err   tolerance for increment to update the solution;
  --   tol_res   tolerance for the residual;
  --   tol_det   tolerance for the determinant;
  --   max       maximal number of Newton iterators.

  -- ON RETURN :
  --   vt        updated consecutive values of continuation parameter;
  --   dt        updated consecutive determinant values;
  --   i         updated index in window for (vt,dt);
  --   x         corrected solution;
  --   fail      true if desired accuracy not met within max iterations;
  --   nit       number of iterations done on the solution;
  --   crtp      type of critical point:
  --               0 if no singularity,
  --               1 if determinant is zero,
  --               2 if orientation of the tangent flipped,
  --               3 if sign of determinant flipped,
  --               4 if minimum of parabola lies inside.

  procedure Monitor_Singularity
               ( file : in file_type; output : in boolean;
                 nd : in double_float;
                 vt,dt : in out Standard_Floating_Vectors.Vector;
                 i : in out integer32;
                 f : in Standard_Floating_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Floating_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Floating_Vectors.Vector;
                 px,pt,dx : in Standard_Floating_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail : out boolean;
                 nit,crtp : out natural32 );
  procedure Monitor_Singularity
               ( file : in file_type; output : in boolean;
                 nd : in Complex_Number;
                 vt,dt : in out Standard_Floating_Vectors.Vector;
                 i : in out integer32;
                 f : in Standard_Complex_Poly_SysFun.Eval_Poly_Sys;
                 jf : Standard_Complex_Jaco_Matrices.Eval_Jaco_Mat;
                 x : in out Standard_Complex_Vectors.Vector;
                 px,pt,dx : in Standard_Complex_Vectors.Vector;
                 tol_err,tol_res,tol_det : in double_float;
                 max : in natural32; fail : out boolean;
                 nit,crtp : out natural32 );

  -- DESCRIPTION :
  --   Monitors determinant, orientation of tangent, and consecutive
  --   values of determinant for possible singularities.

  -- ON ENTRY :
  --   file      for intermediate output and diagnostics;
  --   output    for extra output about correctors;
  --   nd        new value for determinant for t = x(x'last);
  --   vt        3 consecutive values of the continuation parameter;
  --   dt        values of determinants, corresponding to the vt's;
  --   i         index to last element in vt;
  --   f         polynomial system to evaluate the homotopy;          
  --   jf        Jacobi matrix of the homotopy;
  --   x         initial starting point for the solution;
  --   px        previous value along the solution path;
  --   pt        previous tangent vector;
  --   dx        current tangent vector;
  --   tol_err   tolerance for increment to update the solution;
  --   tol_res   tolerance for the residual;
  --   tol_det   tolerance for the determinant;
  --   max       maximal number of Newton iterators.

  -- ON RETURN :
  --   vt        updated consecutive values of continuation parameter;
  --   dt        updated consecutive determinant values;
  --   i         updated index in window for (vt,dt);
  --   x         corrected solution;
  --   fail      true if desired accuracy not met within max iterations;
  --   nit       number of iterations done on the solution;
  --   crtp      type of critical point:
  --               0 if no singularity,
  --               1 if determinant is zero,
  --               2 if orientation of the tangent flipped,
  --               3 if sign of determinant flipped,
  --               4 if minimum of parabola lies inside.

end Standard_Quad_Turn_Points;
