function M = generate_points(num_points, x_range, y_range, func, Nx, Ny)
    x_min = x_range(1);
    x_max = x_range(2);
    y_min = y_range(1);
    y_max = y_range(2);

    hx = (x_max - x_min) / Nx;
    hy = (y_max - y_min) / Ny;

    x_ = linspace(x_min, x_max-hx, Nx) + (hx/2);
    y_ = linspace(y_min, y_max-hy, Ny) + (hy/2);

    [X, Y] = meshgrid(x_, y_);
    Z = func(X, Y);

    surf(X, Y, Z);

    Z = Z(:);
    X = X(:);
    Y = Y(:);
    M = [X, Y, Z];
    

    % Guardar
    save('points.txt', 'M', '-ascii');
end
