%DTLZ_RANGE Returns the decision range of a DTLZ function
%   The range is simply [0,1] for all variables. What varies is the number 
%   of decision variables in each problem. The equation for that is
%     n = (M-1) + k
%   wherein k = 5 for DTLZ1, 10 for DTLZ2-6, and 20 for DTLZ7.
%   This function is meant to easy the trouble of remembering these values and
%   thus it creates these limits for you.
%   
%   Syntax:
%      xlims = get_range(fname, M)
%
%   Input arguments:
%      fname: a string with the name of the function ('dtlz1', 'dtlz2' etc.)
%      M: a scalar with the number of objectives
%
%   Output argument:
%      xlims: a n x 2 matrix wherein the first column is the inferior limit 
%             (0), and the second column, the superior limit of search (1)
function xlims = dtlz_range(fname, M)
     
    switch lower(fname)
      case 'dtlz1'
         k = 5;         
         
      case {'dtlz2', 'dtlz3', 'dtlz4', 'dtlz5'} 
         k = 10;         
         
      case 'dtlz6'
         k = 10;         
         
      case 'dtlz7'
         k = 20;         

      otherwise
         error('Sorry, what the heck of a function is %s?', fname)
   end

   n = (M-1) + k; %number of decision variables
   xlims = [zeros(n,1) ones(n,1)];

