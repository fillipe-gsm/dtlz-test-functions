function fx = dtlz1(x, M)
%DTZL1 DTLZ1 multi-objective function
%   This function represents a hyper-plane.
%   Using k = 5, the number of dimensions must be n = (M - 1) + k, with M the
%   number of objectives.
%
%   The Pareto front of this function happens at xm := x(n-k+1:end) = 0.5,
%   that is, when the last k variables are all equal to 0.5. The first
%   M-1 variables are varied to map the whole Pareto front. Of course, this
%   is not the easiest thing to do for more than M = 3 objectives. However,
%   the hyper-surface is a hyper-plane satisfying the equation
%      f1 + f2 + f3 + ... + fm = 0.5
%
%   Syntax:
%      fx = dtzl1(x, M)
%
%   Input arguments:
%      x: a (n x mu) matrix with mu points and dimension n
%      M: a scalar with the number of objectives
%
%   Output argument:
%      fx: a m x mu matrix with mu points and their m objectives computed at
%         the input
%
%   Example 1: Evaluate DTLZ at random points
%      If M = 2, a random point x needs to have dimension n = (2 - 1) + k = 6
%      using k = 5. Thus, x must be a column vector of size 6 x 1:
%
%         x = rand(6, 1);
%         fx = dtlz1(x, 2); %returns a 2 x 1 vector
%
%      It is possible to evaluate multiple points at once. For mu points, x
%      becomes a (n x mu) matrix. For instance, for mu = 10 points:
%
%         x = rand(6, 10);
%         fx = dtlz1(x, 2); %fx is now a 2 x 10 matrix
%
%      For other numbers of objectives, update n accordingly. For example, if
%      M = 10, x should have dimension n = (10 - 1) + k = 14:
%
%         x = rand(14, 1);
%         fx = dtlz1(x, 10); %returns a 10 x 1 vector
%
%   Example 2: Mapping the Pareto front
%      For M = 2, x has dimension n = 6, wherein the last k = 5 variables should
%      be equal to 0.5 when x is in the Pareto-optimal set. In that case, we can
%      fix these last variables e vary the first one from 0 to 1 in order to map
%      the front:
%
%         N = 100; %number of points
%         x1 = linspace(0, 1, N);
%         x2to5 = repmat(0.5, [5, N]);
%         x = [x1; x2to5];
%         fx = dtlz1(x, 2);
%     
%      Plot these points to verify they are indeed in a plane (a straight line
%      in this case):
%
%         plot(fx(1,:), fx(2,:), 'o');

k = 5; %as suggested by Deb
% Error check: the number of dimensions must be M-1+k
n = (M-1) + k;
if size(x,1) ~= n
   error(['Using k = 5, we require the dimension size to be '...
   'n = (M - 1) + k = %d in this case.'], n)
end

xm = x(n-k+1:end,:); %xm contains the last k variables
g = 100*(k + sum((xm - 0.5).^2 - cos(20*pi*(xm - 0.5)),1));

% Compute the functions
% The first and the last will be written separately to facilitate things
fx(1,:) = 1/2*prod(x(1:M-1,:),1).*(1 + g);
for ii = 2:M-1
   fx(ii,:) = 1/2*prod(x(1:M-ii,:),1).*(1 - x(M-ii+1,:)).*(1 + g);
end
fx(M,:) = 1/2*(1 - x(1,:)).*(1 + g);
