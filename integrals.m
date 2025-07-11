function value = integrals(h,k,coefs_l,coefs_r)
    frag1 = 0;
    frag2 = 0;
    frag3 = 0;
 

    prod_coefs = @(il,jl,ir,jr) coefs_l((il-1)*4 + jl) * coefs_r((ir-1)*4 + jr);
    for il = 0:3
        for ir = 0:3
            for jl = 0:3
                for jr = 0:3
                    if il>=2 && ir>=2
                        frag1 = frag1 + (1/h^3)*(prod_coefs((il+1),(jl+1),(ir+1),(jr+1)) * (il*ir)*(il-1)*(ir-1))/((il + ir - 3)*(jl + jr + 1));
                    end
                    if jl>=2 && jr>=2
                        frag2 = frag2 + (1/k^3)*(prod_coefs((il+1),(jl+1),(ir+1),(jr+1)) * (jl*jr)*(jl-1)*(jr-1))/((jl + jr - 3)*(il + ir + 1));
                    end
                    if il>=1 && ir>=1 && jl>=1 && jr>=1
                        frag3 = frag3 + (2/(h*k))*(prod_coefs((il+1),(jl+1),(ir+1),(jr+1)) * (il)*(ir)*(jl)*(jr))/((il + ir - 1)*(jl + jr - 1));
                    end
                end
            end
        end
    end

    value = frag1 + frag2 + frag3;
end