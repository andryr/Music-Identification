function [name, extension] = split_filename(filename)
% separates filename and extension
    s = strsplit(filename, '.');
    extension = s{end};
    name = join(s(1:end-1), '.');
    name = name{1};
end

