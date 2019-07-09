%DTZL3 DTLZ3 multi-objective function
%   This function represents a hyper-sphere like DTLZ2, but it has more (false)
%   local optima.
%   
%   The Pareto optimal solutions are obtained when the last k variables of x
%   are equal to 0.5.
%
%   Syntax:
%      fx = dtzl3(x, M)
%
%   Input arguments:
%      x: a n x mu matrix with mu points and n dimensions
%      M: a scalar with the number of objectives
%
%   Output argument:
%      fx: a m x mu matrix with mu points and their m objectives computed at
%          the input
%   
%   Example: Mapping the Pareto-optimal front
%      Since the Pareto front here is equal to the DTLZ2 function, the code is
%      basically the same:
%         
%         N = 100; %number of points
%         x1 = linspace(0, 1, N);
%         x2to11 = repmat(0.5, [10, N]);
%         x = [x1; x2to11];
%         fx = dtlz3(x, 2);
%         plot(fx(1,:), fx(2,:), 'o');         
function fx = dtlz3(x, M)
   k = 10;
   dtlz_dimension_check(x, M, k);

   n = (M-1) + k;
   xm = x(n-k+1:end,:); %xm contains the last k variables
   g = 100*(k + sum((xm - 0.5).^2 - cos(20*pi*(xm - 0.5)),1));

   % Compute the functions
   fx(1,:) = (1 + g).*prod(cos(pi/2*x(1:M-1,:)),1);
   for ii = 2:M-1
      fx(ii,:) = (1 + g) .* prod(cos(pi/2*x(1:M-ii,:)),1) .* ...
         sin(pi/2*x(M-ii+1,:));
   end
   fx(M,:) = (1 + g).*sin(pi/2*x(1,:));
