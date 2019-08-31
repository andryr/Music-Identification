function [M] = add_entry(M, key, val)
% adds an entry to a hashtable
    if isKey(M, key)
       L = M(key);
       L = [L val];
       M(key) = L;
    else
        M(key) = [val];
    end
end