function S = build_S(Nx, Ny, x_range, y_range, points)
    phi = load('coeficients.txt')';
    x_min = x_range(1);
    y_min = y_range(1);
    x_max = x_range(2);
    y_max = y_range(2);
    h = (x_max - x_min) / Nx;
    k = (y_max - y_min) / Ny;
    n = Nx*Ny;
    S = zeros(4*n,4*n);
    stencil = build_stencil(Nx, Ny);

    movs = [0, 0; 0, 1; 1, 1; 1, 0];

    %vert1                 vert2                 vert3                 ...
    %dof1 dof2 dof3 dof4 | dof1 dof2 dof3 dof4 | dof1 dof2 dof3 dof4 | ... 
    for si=1:Nx 
        for sj=1:Ny
            idx_s = stencil(si,sj);
            for il=1:4
                for jl=1:4
                    coefs_l = phi((il-1)*4 + 1,:);
                    for ir=1:4
                        for jr=1:4
                            coefs_r = phi((i-1)*4 + j,:);
                        end
                    end
                end
            end
        end 
    end
    
end