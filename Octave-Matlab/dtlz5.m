%DTZL5 DTLZ5 multi-objective function
%   This function represents a curve, no matter the number of dimensions.   
%   The Pareto optimal solutions are obtained when the last k variables of x
%   are equal to 0.5.
%
%   NOTE: After checking the paper and a few implementations (some apparently
%   from the authors), there seems to be two mistakes in the text:
%      1. There is a gr function in the text, but the same auxiliar g function 
%         is used instead;
%      2. There is no pi/2 multiplication inside the sine and cosine functions.
%   The code adopted here reflects these notes.
%
%   Syntax:
%      fx = dtzl5(x, M)
%
%   Input arguments:
%      x: a (n x mu) matrix with mu points and n dimensions
%      M: a scalar with the number of objectives
%
%   Output argument:
%      fx: a (m x mu) matrix with mu points and their m objectives computed at
%          the input
%
%   Example: Mapping Pareto-optimal front with 3 objectives
%      Since this function is a curve in any number of dimensions, it is more
%      interesting to plot its Pareto-optimal front with 3 objectives. For that,
%      the first two variables will vary from 0 to 1, while the last k = 10 will
%      be fixed to 0.5.
%      
%         N = 20; %the actual number of solutions will be N^2         
%         xrange = linspace(0, 1, N);
%         x1to2 = zeros(2, 0);
%         for i = xrange
%            x1to2 = [x1to2, [i(ones(1,N)); xrange]];
%         end
%         x5to12 = 0.5(ones(10, N^2));
%         x = [x1to2; x5to12];
%         fx = dtlz5(x, 3);
%         plot3(fx(1,:), fx(2,:), fx(3,:), 'o');
%      
%      Rotate this plot to check how it is actually a curve.      
function fx = dtlz5(x, M)
   k = 10;
   dtlz_dimension_check(x, M, k);
   
   n = (M-1) + k;   
   % There is a gr in the article. But, as used in the file from the authors,
   % gr = g 
   xm = x(n-k+1:end,:); %xm contains the last k variables
   g = sum((xm - 0.5).^2, 1); 

   theta(1,:) = pi/2*x(1,:);
   gr = g(ones(M-2,1),:); %replicates gr for the multiplication below
   theta(2:M-1,:) = pi./(4*(1+gr)) .* (1 + 2*gr.*x(2:M-1,:));

   % Finally, writes down the functions (there was a mistake in the article.
   % There is no pi/2 multiplication inside the cosine and sine functions)
   fx(1,:) = (1 + g).*prod(cos(theta(1:M-1,:)),1);
   for ii = 2:M-1
      fx(ii,:) = (1 + g) .* prod(cos(theta(1:M-ii,:)),1) .* ...
         sin(theta(M-ii+1,:));
   end
   fx(M,:) = (1 + g).*sin(theta(1,:));