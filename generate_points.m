function M = generate_points(x_range, y_range, func, Nx_points, Ny_points)
    x_min = x_range(1);
    x_max = x_range(2);
    y_min = y_range(1);
    y_max = y_range(2);

    hx = (x_max - x_min) / Nx_points;
    hy = (y_max - y_min) / Ny_points;

    x_ = linspace(x_min + hx, x_max-hx, Nx_points);
    y_ = linspace(y_min + hy, y_max-hy, Ny_points);

    [X, Y] = meshgrid(x_, y_);
    Z = func(X, Y);

    %surf(X, Y, Z);

    Z = Z(:);
    X = X(:);
    Y = Y(:);
    M = [X, Y, Z];
    

    % Guardar
    save('points.txt', 'M', '-ascii');
end
