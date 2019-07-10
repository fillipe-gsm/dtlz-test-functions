%DTZL4 DTLZ4 multi-objective function
%   This function represents a hyper-sphere as DTLZ2. The difference is that
%   there is a parameter to bias the search into some regions. So, equally
%   spaced points in the decision space correspond to crowded points in the
%   objective space. If this is good or not it depends on the Decision Maker.
%
%   The Pareto optimal solutions are obtained when the last k variables of x
%   are equal to 0.5.
%
%   Syntax:
%      fx = dtzl4(x, M)
%
%   Input arguments:
%      x: a n x mu matrix with mu points and n dimensions
%      M: a scalar with the number of objectives
%
%   Output argument:
%      fx: a M x mu matrix with mu points and their M objectives computed at
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
%         fx = dtlz4(x, 2);
%         plot(fx(1,:), fx(2,:), 'o');
%
%      Notice how, in this case, points equally spaced in the variable space do
%      not translate into equally spaced solutions in the objective one. This is
%      a challenge to Evolutionary Algorithms.
function fx = dtlz4(x, M)
   k = 10;
   alpha = 100;
   dtlz_dimension_check(x, M, k);

   n = (M-1) + k;
   xm = x(n-k+1:end,:); %xm contains the last k variables
   g = sum((xm - 0.5).^2, 1);

   % Compute the functions
   fx(1,:) = (1 + g).*prod(cos(pi/2*x(1:M-1,:).^alpha),1);
   for ii = 2:M-1
      fx(ii,:) = (1 + g) .* prod(cos(pi/2*x(1:M-ii,:).^alpha),1) .* ...
         sin(pi/2*x(M-ii+1,:).^alpha);
   end
   fx(M,:) = (1 + g).*sin(pi/2*x(1,:).^alpha);
