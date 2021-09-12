function [result, alpha, beta] = TPS(xi_1, xi_2, yi, lambda)
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

    %%
    Nx = 256;
    points = double(1):double(Nx);
    points2 = double(1):double(Nx);
    
    Px = transpose([ones(Nx,1) transpose(points) transpose(points2)]);

    x_a2 = transpose([points; points2]);
    x_b2 = [xi_1 xi_2];
    squaredDist2 = sqrtDist(x_a2, x_b2);
    Kx = log(squaredDist2 + eps).*squaredDist2/2;

    y = [Kx transpose(Px)]*[alpha; beta];

    x1 = linspace(0, 256, Nx);
    x2 = linspace(0, 256, Nx);
    [X1,X2] = meshgrid(x1,x2);
    CO(:,:,1) = zeros(Nx); % red
    CO(:,:,2) = ones(Nx).*linspace(0.5,0.6,Nx); % green
    CO(:,:,3) = ones(Nx).*linspace(0,1,Nx); % blue
    %surf(X1,X2,y);
    figure;
    surf(X1,y,X2, CO);
    title(sprintf('Plane for the lambda: %.2f', lambda));
end
