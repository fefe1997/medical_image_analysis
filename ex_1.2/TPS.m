function [result, alpha, beta, y] = TPS(xi_1, xi_2, yi, lambda)
% Calculate Thin Plate Spline for values x1, x2, x3
%% Populate some test data
 %   yi = [3; 1; 1; 2];
 %   xi_1 = [1; 1; -1; -1];
 %   xi_2 = [1; -1; 1; -1];

    
    
 %   P = [1 1 1 1; 1 1 -1 -1; 1 -1 1 -1];
    
 %   lambda = 0;
%    I = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
%% Calculate the size and I matrix
    n = size(yi, 1);
    I = eye(n);
    one_m = ones(n, 1);
    size(one_m)
    P = cat(2, one_m, xi_1, xi_2)';
    
%%
    x_a = [xi_1 xi_2];
    x_b = [xi_1 xi_2];

 %% Get distances
    squaredDist = sqrtDist(x_a, x_b);
    K = log(squaredDist + eps).*squaredDist/2;
   
    A = [K+lambda.*I transpose(P); P zeros(size(P, 1))];
    y = [yi; zeros(3,1)];
    y = double(y);
    
    result = A\y;
    trace(A)
    alpha = result(1:3);
    beta = result(4:end);
end
