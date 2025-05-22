function [x0, y0] = find_rectangle(x, y, h, k, x_min, y_min)
    % Find the rectangle

    epsilon = 0;
    i = floor((x - x_min - epsilon) / h);
    j = floor((y - y_min - epsilon) / k);

    x0 = x_min + i * h;
    y0 = y_min + j * k;
end