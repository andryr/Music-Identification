function [P] = peaks(M, radius)
% computes the local maxima matrix
    nhood = ones(radius * 2 + 1, radius * 2 + 1);
    nhood(radius+1,radius+1) = 0;
    J = imdilate(M, nhood);
    P = J >= 0.0005 &  M > J; % only keep peaks that are greater than a certain threshold
end