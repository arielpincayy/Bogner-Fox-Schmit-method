function stencil = build_stencil(Nx,Ny)
    c = 1;
    stencil = zeros(Nx, Ny);
    for i=1:Ny
        for j=1:Nx
            stencil(i,j) = c;
            c = c + 1;
        end
    end
end