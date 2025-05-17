function mesh = bogner_fox_schmit(h, k, x_range, y_range, points, Nx, Ny)
    x_min = x_range(1);
    y_min = y_range(1);
    x_max = x_range(2);
    y_max = y_range(2);


    A = build_A(h, k, x_range, y_range, points);
    F = points(:,3);
    alphas = (A' * A) \ (A' * F);
    mesh = alphas;
end




