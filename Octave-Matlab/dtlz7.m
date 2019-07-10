%DTZL7 DTLZ7 multi-objective function
%   This function has a disconnected Pareto front
%
%   The Pareto optimal solutions are obtained when the last k variables of x
%   are equal to 0.
%
%   Syntax:
%      fx = dtzl7(x, M)
%
%   Input arguments:
%      x: a n x mu matrix with mu points and n dimensions
%      M: a scalar with the number of objectives
%
%   Output argument:
%      fx: a M x mu matrix with mu points and their M objectives computed at
%          the input
%
%   Example: Mapping Pareto-optimal front with 2 objectives
%      Following the same pattern of the other examples:
%
%         N = 100; %number of points
%         x1 = linspace(0, 1, N);
%         x2to21 = zeros(20, N);
%         x = [x1; x2to21];
%         fx = dtlz7(x, 2);
%         plot(fx(1,:), fx(2,:), 'o');
%
%      The Pareto-optimal may seem connected, but a close look will show that
%      some parts of this "front" are actually dominated. To filter these
%      solutions, use the NDSET function created for this:
%
%         ispar = ndset(fx);
%         fx = fx(:,ispar); %leave only the non-dominated points
%         close;
%         plot(fx(1,:), fx(2,:), 'o'); %check the correct nonconnected front now
%
%   See also ndset
function fx = dtlz7(x, M)
   k = 20;
   dtlz_dimension_check(x, M, k);

   n = (M-1) + k;
   % Write down the auxiliar function g
   xm = x(n-k+1:end,:); %xm contains the last k variables
   g = 1 + 9/k*sum(xm,1);

   % Compute the first M-1 objective functions
   fx(1:M-1,:) = x(1:M-1,:);

   % The last function requires another auxiliar variable
   gaux = g(ones(M-1,1),:); %replicate the g function
   h = M - sum(fx./(1+gaux).*(1 + sin(3*pi*fx)),1);
   fx(M,:) = (1 + g).*h;
