function [ phi ] = basis_functions()
    coefs = load('X_matrix.txt')';
    phi = coefs;
end