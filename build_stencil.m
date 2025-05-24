function stencil = build_stencil(Nx,Ny)
    c = 1;
    stencil = zeros(Nx, Ny);
    for i=1:Nx
        for j=1:Ny
            stencil(i,j) = c;
            c = c + 1;
        end
    end
end