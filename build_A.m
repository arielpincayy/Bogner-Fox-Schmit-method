function A = build_A(h, k, x_range, y_range, points)
    phi = load('coeficients.txt')';
    xy = points(:,1:2);

    x_min = x_range(1);
    y_min = y_range(1);
    x_max = x_range(2);
    y_max = y_range(2);

    %Calcula el numero de nodos en la malla
    Nx = floor((x_max - x_min) / h) + 1;
    Ny = floor((y_max - y_min) / k) + 1;

    m = size(points,1);
    n = Nx*Ny;

    A = zeros(m,4*n);
    stencil = build_stencil(Nx, Ny);

    for i=1:m
        x = xy(i,1);
        y = xy(i,2);

        %Calcula la posicion del nodo perteneciente al punto 0 del rectangulo
        [x0, y0] = find_rectangle(x, y, h, k, x_min, y_min);
        
        %Calcula la posicion del nodo perteneciente al punto 0 del rectangulo
        Ni = floor((x0 - x_min)/h) + 1;
        Nj = floor((y0 - y_min)/k) + 1;

        %Calcula las coordenadas de los vertices del rectangulo
        verts = [x0, y0; x0, y0+k; x0+h, y0+k; x0+h, y0];
        
        %Define el movimiento de los vertices respecto al centro del rectangulo
        movs = [0, 0; 0, 1; 1, 1; 1, 0];

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
                coefs = phi((j-1)*4 + l, :);
                %Traslada al rectangulo referencia
                xi = (x - x_) / h;
                eta = (y - y_) / k;
                %Evalua la funcion base local, y suma a la funcion base global
                pol = eval_polin(coefs, xi, eta);
                %Suma el resultado a la matriz global
                A(i, idx_) = A(i, idx_) + pol;
                %Desplaza al siguiente elemento de la matriz
                idx_ = idx_ + 1;
            end
        end
    end

end

%vertices = [(0,0),(0,1),(1,1),(1,0)]

