function M = generate_points(x_range, y_range, func, Nx, Ny, num_points)
    M = zeros((Nx-1)*(Ny-1)*num_points, 3);
    h = (x_range(2) - x_range(1)) / (Nx - 1);
    k = (y_range(2) - y_range(1)) / (Ny - 1);

    for i = 1:Nx-1
        for j = 1:Ny-1
            % Definir rango de rectángulo
            x_rect_range = [x_range(1) + (i-1)*h, x_range(1) + i*h];
            y_rect_range = [y_range(1) + (j-1)*k, y_range(1) + j*k];

            % Generar puntos aleatorios
            points = rand_points(x_rect_range, y_rect_range, func, num_points, h, k);

            % Guardar en M con el índice correcto
            idx = ((j-1) + (i-1)*(Ny-1)) * num_points + 1;
            M(idx : idx + num_points - 1, :) = points;
        end
    end

    save('points.txt', 'M', '-ascii');
end

function points = rand_points(x_rect_range, y_rect_range, func, num_points, h, k)
    x_min = x_rect_range(1);
    x_max = x_rect_range(2);
    y_min = y_rect_range(1);
    y_max = y_rect_range(2);

    points = zeros(num_points, 3);
    for n = 1:num_points
        x = x_min + ((x_max - x_min) * rand());
        y = y_min + ((y_max - y_min) * rand());
        z = func(x, y);
        points(n, :) = [x, y, z];
    end
end
