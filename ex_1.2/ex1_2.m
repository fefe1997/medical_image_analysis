function im = getAndRemoveBias(x1, x2, y, im_original, mask, approx)
    %% Seed sample data for testing from the file
    S = load('abdomen.mat');
    im_original = S.abdomen;
    mask = S.roi;
    S = load('fatPoints.mat');
    x1 = S.x1;
    x2 = S.x2;
    y = S.y;
    approx = 0.5;

    
    %%
    % Calculates the bias using TPS, multiply by a mask and divide from
    % original image. Return modified image
    % Get TPS plane
    XY = [x1; x2];
    st = tpaps(XY, double(y), approx);
    %% Show the plane
    figure;
    fnplt(st);
    title('Plane fitted to fat points');
    hold on
    plot3(x1, x2, y, 'xr');
    hold off
    %% Create coordinate vector
    for x = 1:256
        for y = 1:256
            XI(1, x + (y - 1) * 256) = y;
            XI(2, x + (y - 1) * 256) = x;
        end
    end
    XI = double(XI);
    %% Get values from the plane
    res = fnval(st, XI);
    res = reshape(res, [256, 256]);
    res = uint8(res);
    res = res.* mask;
    %% Show the bias
    figure;
    imshow(res);
    title('Bias Field');
    %% Multiply by divide the image
    im = double(im_original.*mask);
    im = imdivide(im, double(res));
    figure;
    imshow(im);
    title(sprintf('corrected image for approx = %.2f', approx));
    
    
    
end