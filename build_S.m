function S = build_S(Nx, Ny, x_range, y_range)
    phi = load('coeficients.txt')';
    x_min = x_range(1);
    y_min = y_range(1);
    x_max = x_range(2);
    y_max = y_range(2);
    h = (x_max - x_min) / Nx;
    k = (y_max - y_min) / Ny;
    n = Nx * Ny;
    S = zeros(4*n, 4*n);
    stencil = build_stencil(Nx, Ny);

    movs = [0, 0; 0, 1; 1, 1; 1, 0];

    for si = 1:Nx-1
        for sj = 1:Ny-1
            % Índices de los 4 vértices del rectángulo actual
            vertex_indices = zeros(1, 4);
            for v = 1:4
                i_ = si + movs(v,1);
                j_ = sj + movs(v,2);
                vertex_indices(v) = stencil(i_, j_);
            end

            % Global DOFs asociados a este rectángulo (4 DOFs por vértice)
            global_dofs = [];
            for v = 1:4
                idx = vertex_indices(v);
                global_dofs = [global_dofs, 4*(idx-1)+1 : 4*idx];
            end

            % Arma S_local de 16x16 e intégrala a S
            for i = 1:16
                coefs_l = phi(i,:);
                for j = 1:16
                    coefs_r = phi(j,:);
                    val = integrals(h, k, coefs_l, coefs_r);
                    S(global_dofs(i), global_dofs(j)) += val;
                end
            end
        end
    end
end
