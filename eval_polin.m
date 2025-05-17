function value = eval_polin(coefs, x, y)
    value = 0;
    for i = 0:3
        for j = 0:3
            idx = i*4 + j + 1;
            value = value + (coefs(idx) * (x^i) * (y^j));
        end
    end
end