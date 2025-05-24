function [x0, y0] = find_rectangle(x, y, h, k, x_min, y_min)
    % Find the rectangle
    i = floor((x - x_min) / h);
    j = floor((y - y_min) / k);

    x0 = x_min + i * h;
    y0 = y_min + j * k;
end