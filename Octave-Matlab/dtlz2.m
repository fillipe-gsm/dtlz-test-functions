%DTZL2 DTLZ2 multi-objective function
%   This function represents a hyper-sphere.
%   The Pareto-optimal solutions are obtained when the last k variables of x
%   are equal to 0.5.
%
%   Syntax:
%      fx = dtzl2(x, M)
%
%   Input arguments:
%      x: a (n x mu) matrix with mu points dimension n
%      M: a scalar with the number of objectives
%
%   Output argument:
%      fx: a (m x mu) matrix with mu points and their m objectives computed at
%          the input
%
%   Example: Mapping the Pareto-optimal front
%      For M = 2, x has dimension n = 11, wherein the last k = 10 variables 
%      should be equal to 0.5 when x is in the Pareto-optimal set. In that case, 
%      we can fix these last variables e vary the first one from 0 to 1 in order 
%      to map the front:
%         
%         N = 100; %number of points
%         x1 = linspace(0, 1, N);
%         x2to11 = repmat(0.5, [10, N]);
%         x = [x1; x2to11];
%         fx = dtlz2(x, 2);
%
%      Plot these points to verify they are indeed semi-circle:
%
%         plot(fx(1,:), fx(2,:), 'o');
function fx = dtlz2(x, M)
   k = 10;
   dtlz_dimension_check(x, M, k);
   
   n = (M-1) + k;   
   xm = x(n-k+1:end,:); %xm contains the last k variables
   g = sum((xm - 0.5).^2, 1);

   % Compute the functions
   fx(1,:) = (1 + g).*prod(cos(pi/2*x(1:M-1,:)),1);
   for ii = 2:M-1
      fx(ii,:) = (1 + g) .* prod(cos(pi/2*x(1:M-ii,:)),1) .* ...
         sin(pi/2*x(M-ii+1,:));
   end
   fx(M,:) = (1 + g).*sin(pi/2*x(1,:));
