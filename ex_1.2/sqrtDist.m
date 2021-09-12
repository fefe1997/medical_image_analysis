function squaredDist = sqrtDist(x_a, x_b)
    N_a = size(x_a, 1);
    N_b = size(x_b, 1);
    squaredDist = zeros(N_a,N_b);
    for coordinateNo = 1:2
       squaredDist = squaredDist + (repmat(x_a(:, coordinateNo), [1 N_b]) - repmat(transpose(x_b(:, coordinateNo)), [N_a 1])).^2;
    end
end