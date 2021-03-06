
yi = [3; 1; 1; 2];
xi_1 = [1; 1; -1; -1];
xi_2 = [1; -1; 1; -1];

P = [1 1 1 1; 1 1 -1 -1; 1 -1 1 -1];
lambda = 1;
I = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];

x_a = [xi_1 xi_2];
x_b = [xi_1 xi_2];
N_a = size(x_a, 1);
N_b = size(x_b, 1);
squaredDist = zeros(N_a,N_b);
for coordinateNo = 1:2
   squaredDist = squaredDist + (repmat(x_a(:, coordinateNo), [1 N_b]) - repmat(transpose(x_b(:, coordinateNo)), [N_a 1])).^2;
end
K = log(squaredDist + eps).*squaredDist/2;

A = [K+lambda.*I transpose(P); P zeros(3,3)];


y = [yi; zeros(3,1)];

result = A\y;
alpha = result(1:3);
beta = result(4:end);

Nx = 1000;
points = linspace(-1.5,1.5,Nx);
points2 = linspace(-1.4,1.4,Nx);
Px = transpose([ones(Nx,1) transpose(points) transpose(points2)]);

x_a2 = transpose([points; points2]);
x_b2 = [xi_1 xi_2];
N_a2 = size(x_a2, 1);
N_b2 = size(x_b2, 1);
squaredDist2 = zeros(N_a2,N_b2);
for coordinateNo = 1:2
   squaredDist2 = squaredDist2 + (repmat(x_a2(:, coordinateNo), [1 N_b2]) - repmat(transpose(x_b2(:, coordinateNo)), [N_a2 1])).^2;
end
Kx = log(squaredDist2 + eps).*squaredDist2/2;

y = [Kx transpose(Px)]*[alpha; beta];

x1 = linspace(-1.5,1.5,Nx);
x2 = linspace(-1.5,1.5,Nx);
[X1,X2] = meshgrid(x1,x2);
%surf(X1,X2,y);
figure;
surf(X1,y,X2, CO);
title(sprintf('Plane for the lambda: %.2f', lambda));
