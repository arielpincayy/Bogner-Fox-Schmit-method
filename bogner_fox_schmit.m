function mesh = bogner_fox_schmit(Nx, Ny, x_range, y_range, points)
    x_min = x_range(1);
    y_min = y_range(1);
    x_max = x_range(2);
    y_max = y_range(2);

    h = (x_max - x_min) / Nx;
    k = (y_max - y_min) / Ny;
    m = size(points,1);
    n = Nx*Ny;

    A = build_A(Nx, Ny,x_range, y_range, points);
    S = build_S(Nx, Ny, x_range, y_range);
    F = points(:,3);
    alpha = ((A' * A) + 0.00*(S)) \ (A' * F);

    mesh = zeros(m,1);

    stencil = build_stencil(Nx, Ny);

    coefs = load('coeficients.txt')';

    for i=1:m
        x = points(i,1);
        y = points(i,2);
        

        %Calcula la posicion del nodo perteneciente al punto 0 del rectangulo
        [x0, y0] = find_rectangle(x, y, h, k, x_min, y_min);

        %Calcula la posicion del nodo perteneciente al punto 0 del rectangulo
        Ni = floor((x0 - x_min)/h) + 1;
        Nj = floor((y0 - y_min)/k) + 1;

        %Calcula las coordenadas de los vertices del rectangulo
        verts = [x0, y0; x0, y0+k; x0+h, y0+k; x0+h, y0];

        %Define el movimiento de los vertices respecto al centro del rectangulo
        movs = [0, 0; 0, 1; 1, 1; 1, 0];

        mesh(i) = 0;

        for j=1:4

            %Calcula las coordenadas del vertice del rectangulo
            x_ = verts(j,1);
            y_ = verts(j,2);

            %Calcula el indice del vertice en la matriz de stencil
            Ni_ = Ni + movs(j,1);
            Nj_ = Nj + movs(j,2);

            %Verifica que el vertice este dentro de la malla
            if(Ni_ < 1 || Ni_ > Nx || Nj_ < 1 || Nj_ > Ny)
                continue;
            end
            idx = stencil(Ni_, Nj_);

            %Mapea el vertice a su posicion en la matriz global siguiendo el siguiente esquema:
            %vert1                 vert2                 vert3                 ...
            %dof1 dof2 dof3 dof4 | dof1 dof2 dof3 dof4 | dof1 dof2 dof3 dof4 | ... 
            idx_ = 1 + 4*(idx-1);
            for l=1:4
                local_coefs = coefs((j-1)*4 + l, :);
                %Traslada al rectangulo referencia
                xi = (x - x_) / h;
                eta = (y - y_) / k;

                mesh(i) = mesh(i) + eval_polin(local_coefs, xi, eta) * alpha(idx_);
                idx_ = idx_ + 1;
            end
        end
    end

    Nx_points = int32(sqrt(m));
    Ny_points = int32(sqrt(m));

    figure(1);
    X = reshape(points(:,1), Ny_points, Nx_points);
    Y = reshape(points(:,2), Ny_points, Nx_points);
    Z = reshape(mesh, Ny_points, Nx_points);
    surf(X, Y, Z);
    shading interp;
    xlabel('x'); ylabel('y'); zlabel('z');
    title('Bogner Scmit Approximation');

    figure(2);
    X = reshape(points(:,1), Ny_points, Nx_points);
    Y = reshape(points(:,2), Ny_points, Nx_points);
    Z = reshape(points(:,3), Ny_points, Nx_points);
    surf(X, Y, Z);
    shading interp;
    xlabel('x'); ylabel('y'); zlabel('z');
    title('Original Function');

    figure(3);
    %Sacatterplot de los puntos por Bogner Fox Schmit
    scatter3(points(:,1), points(:,2), mesh, 10, 'filled');
    xlabel('x'); ylabel('y'); zlabel('z');
    title('Bogner Fox Schmit Approximation');

end




