%DTLZ_DISTANCE Finds the distance of a point to the optimum
%   Since, in the DTLZ functions, the last k variables of a decision vector
%   represent the "distance" to the Pareto set and the first ones the
%   "position" in the front, a good way to find the distance to the optimum
%   is to check these last variables.
%   For each function, the last k variables must be a given value, like 0.5,
%   1, 0 etc. Hence, the distance from xopt(end-k+1:end) to 0.5, (or 0, or 
%   whatever) will provide a measure of how far the points are to the optimal 
%   set.
%
%   Syntax:
%      d = dtlz_distance(fname, xopt)
%
%   Input arguments:
%      fname: a string with the name of the function (e.g., 'dtlz1')
%      xopt: a (n x mu) matrix of mu individuals of dimension n (it must be
%            in accordance with the required dimension given by Deb)
%
%   Output argument:
%      d: a mu-vector with the distance of each point to the optimal set
function d = dtlz_distance(fname, xopt)
   % For each function, a different value of k and reference point is given   
   switch lower(fname)
      case 'dtlz1' %k = 5 and x(last) = 0.5
         k = 5;
         value = 0.5;
         
      case {'dtlz2', 'dtlz3', 'dtlz4', 'dtlz5'} %k = 10 and x(last) = 0.5
         k = 10;
         value = 0.5;
         
      case 'dtlz6' %k = 10 and x(last) = 0
         k = 10;
         value = 0;
         
      case 'dtlz7' %k = 20 and x(last) = 0
         k = 20;
         value = 0;

      otherwise
         error('Sorry, what the heck of a function is %s?', fname)
   end
   
   mu = size(xopt,2); %number of points
   xlast = value(ones(k, mu)); %replicate the required value
   d = sum((xopt(end-k+1:end,:) - xlast).^2, 1);