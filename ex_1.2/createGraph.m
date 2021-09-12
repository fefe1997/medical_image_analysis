function y = createGraph(alpha, beta, xi_1, xi_2, lambda)
    %%
    Nx = 256;
    for x = double(1):double(Nx)
        for y = double(1):double(Nx)
            points(x + (y - 1) * 256) = y;
            points2(x + (y - 1) * 256) = x;
        end
    end
%    points = double(1):double(Nx);
%    points2 = double(1):double(Nx);
    
    Px = transpose([ones(Nx * Nx,1) transpose(points) transpose(points2)]);

    x_a2 = transpose([points; points2]);
    x_b2 = [xi_1 xi_2];
    squaredDist2 = sqrtDist(x_a2, x_b2);
    Kx = log(squaredDist2 + eps).*squaredDist2/2;

    y = [Kx transpose(Px)]*[alpha; beta];

    y = reshape(y, [Nx, Nx]);
    x1 = linspace(0, Nx, Nx);
    x2 = linspace(0, Nx, Nx);
    [X1,X2] = meshgrid(x1,x2);
   % CO(:,:,1) = zeros(Nx); % red
   % CO(:,:,2) = ones(Nx).*linspace(0.5,0.6,Nx); % green
   % CO(:,:,3) = ones(Nx).*linspace(0,1,Nx); % blue
    %surf(X1,X2,y);
    figure;
    surf(X1,X2, y);
    title(sprintf('Plane for the lambda: %.2f', lambda));
end