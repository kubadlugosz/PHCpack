/* The file padcon.h contains prototypes to the path trackers which apply
 * Pade approximants to predict solutions, padcon = Pade continuation.
 * By default, compilation with gcc is assumed.
 * To compile with a C++ compiler such as g++,
 * the flag compilewgpp must be defined as "g++ -Dcompilewgpp=1." */

#ifndef __PADCON_H__
#define __PADCON_H__

#ifdef compilewgpp
extern "C" void adainit( void );
extern "C" int _ada_use_c2phc4c ( int task, int *a, int *b, double *c );
extern "C" void adafinal( void );
#else
extern void adainit( void );
extern int _ada_use_c2phc4c ( int task, int *a, int *b, double *c );
extern void adafinal( void );
#endif

int padcon_set_default_parameters ( void );
/*
 * DESCRIPTION :
 *   Sets the default values of the homotopy continuation parameters. */

int padcon_clear_parameters ( void );
/*
 * DESCRIPTION :
 *   Deallocates the allocated space for the parameters. */

void padcon_write_homotopy_continuation_parameters ( void );
/*
 * DESCRIPTION :
 *   Writes the current values of the homotopy continuation parameters.
 *   As a pure C routine which makes no direct access to the Ada code,
 *   but it is too useful to be omitted from the padcon library. */

int padcon_write_homotopy_continuation_parameters_to_defined_output ( void );
/*
 * DESCRIPTION :
 *   Writes the current values of the homotopy continuation parameters
 *   to the defined output file, or to screen if there is no defined
 *   output file set by define_output_file* in phcpack. */

void padcon_tune_homotopy_continuation_parameters ( void );
/*
 * DESCRIPTION :
 *   Interactive loop to tune the homotopy continuation parameters.
 *   As a pure C routine it makes no direct access to the Ada code,
 *   but it is too useful to be omitted from the padcon library. */

int padcon_get_homotopy_continuation_parameter ( int k, double *val );
/*
 * DESCRIPTION :
 *   Returns in val the value of the k-th continuation parameter,
 *   if k ranges between 1 and 12.
 *
 * ON ENTRY :
 *   k        an integer number between 1 and 12.
 *
 * ON RETURN 
 *   val      the value for the k-th homotopy continuation parameter. */

int padcon_set_homotopy_continuation_parameter ( int k, double *val );
/*
 * DESCRIPTION :
 *   Sets the value of the k-th continuation parameter to val,
 *   if k ranges between 1 and 12.
 *
 * ON ENTRY :
 *   k        an integer number between 1 and 12.
 *
 * ON RETURN 
 *   val      the value for the k-th homotopy continuation parameter. */

int padcon_standard_track ( int nbc, char* name, int verbose );
/*
 * DESCRIPTION :
 *   For the defined target, start system, and start solutions,
 *   launches the Pade continuation in standard double precision.
 *
 * ON ENTRY :
 *   nbc      number of characters of the output file name,
 *            equals 0 if no output will be written to file;
 *   name     defines the name of the output file,
 *            the file name has nbc characters;
 *   verbose  if > 0, then more information is written. */

int padcon_dobldobl_track ( int nbc, char* name, int verbose );
/*
 * DESCRIPTION :
 *   For the defined target, start system, and start solutions,
 *   launches the Pade continuation in double double precision.
 *
 * ON ENTRY :
 *   nbc      number of characters of the output file name,
 *            equals 0 if no output will be written to file;
 *   name     defines the name of the output file,
 *            the file name has nbc characters;
 *   verbose  if > 0, then more information is written. */

int padcon_quaddobl_track ( int nbc, char* name, int verbose );
/*
 * DESCRIPTION :
 *   For the defined target, start system, and start solutions,
 *   launches the Pade continuation in quad double precision.
 *
 * ON ENTRY :
 *   nbc      number of characters of the output file name,
 *            equals 0 if no output will be written to file;
 *   name     defines the name of the output file,
 *            the file name has nbc characters;
 *   verbose  if > 0, then more information is written. */

int padcon_standard_initialize_homotopy ( int verbose );
/*
 * DESCRIPTION :
 *   For the defined target and start system,
 *   initializes the homotopy in standard double precision,
 *   for the step-by-step Pade continuation.
 *   If verbose = 1, then extra output will be written. */

int padcon_dobldobl_initialize_homotopy ( int verbose );
/*
 * DESCRIPTION :
 *   For the defined target and start system,
 *   initializes the homotopy in double double precision,
 *   for the step-by-step Pade continuation.
 *   If verbose = 1, then extra output will be written. */

int padcon_quaddobl_initialize_homotopy ( int verbose );
/*
 * DESCRIPTION :
 *   For the defined target and start system,
 *   initializes the homotopy in quad double precision,
 *   for the step-by-step Pade continuation.
 *   If verbose = 1, then extra output will be written. */

int padcon_standard_initialize_parameter_homotopy ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   With the system, defined as target system, and the index idx
 *   for the continuation parameter, initializes the homotopy in
 *   standard double precision for the step-by-step Pade continuation.
 *   If verbose = 1, then extra output will be written. */

int padcon_dobldobl_initialize_parameter_homotopy ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   With the system, defined as target system, and the index idx
 *   for the continuation parameter, initializes the homotopy in
 *   double double precision for the step-by-step Pade continuation.
 *   If verbose = 1, then extra output will be written. */

int padcon_quaddobl_initialize_parameter_homotopy ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   With the system, defined as target system, and the index idx
 *   for the continuation parameter, initializes the homotopy in
 *   quad double precision for the step-by-step Pade continuation.
 *   If verbose = 1, then extra output will be written. */

int padcon_initialize_standard_solution ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   Takes the solution with index idx in the solutions container in
 *   standard double precision and initializes the series-Pade tracker.
 *   If verbose = 1, then extra output will be written. */

int padcon_initialize_dobldobl_solution ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   Takes the solution with index idx in the solutions container in
 *   double double precision and initializes the series-Pade tracker.
 *   If verbose = 1, then extra output will be written. */

int padcon_initialize_quaddobl_solution ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   Takes the solution with index idx in the solutions container in
 *   quad double precision and initializes the series-Pade tracker.
 *   If verbose = 1, then extra output will be written. */

int padcon_standard_predict_correct ( int* fail, int verbose );
/*
 * DESCRIPTION :
 *   Executes one predict-correct step on the current solution and
 *   the defined homotopy in standard double precision.
 *   On return in fail is the failure code of the predict-correct step:
 *   if fail is zero, then the required accuracies were met,
 *   otherwise, either the predict or the correct step failed.
 *   If verbose = 1, then extra output will be written. */

int padcon_dobldobl_predict_correct ( int* fail, int verbose );
/*
 * DESCRIPTION :
 *   Executes one predict-correct step on the current solution and
 *   the defined homotopy in double double precision.
 *   On return in fail is the failure code of the predict-correct step:
 *   if fail is zero, then the required accuracies were met,
 *   otherwise, either the predict or the correct step failed.
 *   If verbose = 1, then extra output will be written. */

int padcon_quaddobl_predict_correct ( int* fail, int verbose );
/*
 * DESCRIPTION :
 *   Executes one predict-correct step on the current solution and
 *   the defined homotopy in quad double precision.
 *   On return in fail is the failure code of the predict-correct step:
 *   if fail is zero, then the required accuracies were met,
 *   otherwise, either the predict or the correct step failed.
 *   If verbose = 1, then extra output will be written. */

int padcon_get_standard_solution ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   Retrieves the current solution and places it at position idx
 *   in the solutions container in standard double precision.
 *   If verbose = 1, then extra output will be written. */

int padcon_get_dobldobl_solution ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   Retrieves the current solution and places it at position idx
 *   in the solutions container in double double precision.
 *   If verbose = 1, then extra output will be written. */

int padcon_get_quaddobl_solution ( int idx, int verbose );
/*
 * DESCRIPTION :
 *   Retrieves the current solution and places it at position idx
 *   in the solutions container in quad double precision.
 *   If verbose = 1, then extra output will be written. */

int padcon_get_standard_forward_pole_radius ( double* frp );
/*
 * DESCRIPTION :
 *   Returns in frp the smallest forward pole radius computed 
 *   by the predictor in standard double precision. */

int padcon_get_dobldobl_forward_pole_radius ( double* frp );
/*
 * DESCRIPTION :
 *   Returns in frp the smallest forward pole radius computed
 *   by the predictor in double double precision.
 *   The returned frp is the high part of the double double number. */

int padcon_get_quaddobl_forward_pole_radius ( double* frp );
/*
 * DESCRIPTION :
 *   Returns in frp the smallest forward pole radius computed
 *   by the predictor in quad double precision.
 *   The returned frp is the highest part of the quad double number. */

int padcon_get_standard_closest_pole ( double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns the real and imaginary parts of the closest pole
 *   respectively in cre and cim, computed by the predictor
 *   in standard double precision.
 *   Results are meaningful only if cre >= 0.0. */

int padcon_get_dobldobl_closest_pole ( double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns the real and imaginary parts of the closest pole
 *   respectively in cre and cim, computed by the predictor
 *   in double double precision.
 *   The cre and cim are the high parts of the double doubles.
 *   Results are meaningful only if cre >= 0.0.  */

int padcon_get_quaddobl_closest_pole ( double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns the real and imaginary parts of the closest pole
 *   respectively in cre and cim, computed by the predictor
 *   in quad double precision.
 *   The cre and cim are the highest parts of the quad doubles.
 *   Results are meaningful only if cre >= 0.0. */

int padcon_get_standard_t_value ( double *tval );
/*
 * DESCRIPTION :
 *   Returns in tval the current t value of the path tracker
 *   which runs in standard double precision. */

int padcon_get_dobldobl_t_value ( double *tval );
/*
 * DESCRIPTION :
 *   Returns in tval the current t value of the path tracker
 *   which runs in double double precision. */

int padcon_get_quaddobl_t_value ( double *tval );
/*
 * DESCRIPTION :
 *   Returns in tval the current t value of the path tracker
 *   which runs in quad double precision. */

int padcon_get_standard_step_size ( double *step );
/*
 * DESCRIPTION :
 *   Returns in tval the current step size of the path tracker
 *   which runs in standard double precision. */

int padcon_get_dobldobl_step_size ( double *step );
/*
 * DESCRIPTION :
 *   Returns in tval the current step size of the path tracker
 *   which runs in double double precision. */

int padcon_get_quaddobl_step_size ( double *step );
/*
 * DESCRIPTION :
 *   Returns in tval the current step size of the path tracker
 *   which runs in quad double precision. */

int padcon_get_standard_series_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the series
 *   coefficient of component with leadidx at position idx, of the
 *   series computed by the predictor in double precision. */

int padcon_get_dobldobl_series_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the series
 *   coefficient of component with leadidx at position idx, of the
 *   series computed by the predictor in double double precision.
 *   The doubles are the highest parts of the double doubles. */

int padcon_get_quaddobl_series_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the series
 *   coefficient of component with leadidx at position idx, of the
 *   series computed by the predictor in quad double precision.
 *   The doubles are the highest parts of the quad doubles. */

int padcon_get_standard_numerator_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the 
 *   coefficient of the numerator of the Pade approximant,
 *   at the component with leadidx at position idx,
 *   computed by the predictor in double precision. */

int padcon_get_dobldobl_numerator_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the
 *   coefficient of the numerator of the Pade approximant,
 *   at the component with leadidx at position idx,
 *   computed by the predictor in double double precision.
 *   The doubles are the highest parts of the double doubles. */

int padcon_get_quaddobl_numerator_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the series
 *   coefficient of the numerator of the Pade approximant,
 *   at the component with leadidx at position idx,
 *   computed by the predictor in quad double precision.
 *   The doubles are the highest parts of the quad doubles. */

int padcon_get_standard_denominator_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the 
 *   coefficient of the denominator of the Pade approximant,
 *   at the component with leadidx at position idx,
 *   computed by the predictor in double precision. */

int padcon_get_dobldobl_denominator_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the
 *   coefficient of the denominator of the Pade approximant,
 *   at the component with leadidx at position idx,
 *   computed by the predictor in double double precision.
 *   The doubles are the highest parts of the double doubles. */

int padcon_get_quaddobl_denominator_coefficient
 ( int leadidx, int idx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the series
 *   coefficient of the denominator of the Pade approximant,
 *   at the component with leadidx at position idx,
 *   computed by the predictor in quad double precision.
 *   The doubles are the highest parts of the quad doubles. */

int padcon_get_standard_pole
 ( int leadidx, int poleidx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the pole
 *   Pade approximant with leadidx at position poleidx,
 *   computed by the predictor in double precision. */

int padcon_get_dobldobl_pole
 ( int leadidx, int poleidx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the pole
 *   Pade approximant with leadidx at position poleidx,
 *   computed by the predictor in double double precision.
 *   The returned doubles are the highest parts of the double doubles. */

int padcon_get_quaddobl_pole
 ( int leadidx, int poleidx, int verbose, double* cre, double* cim );
/*
 * DESCRIPTION :
 *   Returns in cre and cim the real and imaginary parts of the pole
 *   Pade approximant with leadidx at position poleidx,
 *   computed by the predictor in quad double precision.
 *   The returned doubles are the highest parts of the quad doubles. */

int padcon_clear_standard_data ( void );
/*
 * DESCRIPTION :
 *   Deallocates data for the series-Pade tracker in double precision. */

int padcon_clear_dobldobl_data ( void );
/*
 * DESCRIPTION :
 *   Deallocates data for the series-Pade tracker
 *   in double double precision. */

int padcon_clear_quaddobl_data ( void );
/*
 * DESCRIPTION :
 *   Deallocates data for the series-Pade tracker
 *   in quad double precision. */

#endif
