function [H] = generate_hashes(P, f_size)
% computes hashes from the local maxima matrix
    h = zeros(sum(sum(P)), 2);
    n = size(P, 1);
    m = size(P, 2);
    % we "flatten" the matrix P
    k = 1;
    for j = 1:m % j = time index
        for i = 1:n % i = freq index
            if P(i,j) == 1
               h(k, :) = [i j];
               k = k + 1;
            end
        end
    end
    
    l = size(h, 1);
    H = cell((l-f_size)*f_size + f_size*(f_size - 1) /2, 2); % we preallocated H (otherwise it would be too slow)
    k = 1;
    for i = 1:l
        for j = 1:f_size
            if i + j > l
                break
            end
            freq_bin_1 = h(i, 1);
            freq_bin_2 = h(i + j, 1);
            t_1 = h(i, 2);
            t_2 = h(i + j, 2);
            delta_t = t_2 - t_1;
            H(k,:) = {sprintf('%d|%d|%d', freq_bin_1, freq_bin_2, delta_t), t_1};
            k = k + 1;
        end
    end
end