%DTLZ_DIMENSION_CHECK
%   Check the dimension of an input x for a specific DTLZ function, and returns 
%   an error if size(x, 1) is different from (M - 1) + k.
%
%   Syntax:
%      dtlz_dimension_check(x, M, k)
%
%   Input arguments:
%      x: a (n x mu) matrix with mu points and dimension n
%      M: a scalar with the number of objectives
%      k: k parameter specific to each DTLZ function
function dtlz_dimension_check (x, M, k)
   
   n = (M-1) + k; %required dimension   
   if size(x,1) ~= n
      error(['Using k = %d, we require the dimension size to be '...
         'n = (M - 1) + k = %d in this case.'], k, n)
   end