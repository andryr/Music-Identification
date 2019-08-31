function [R] = tests(rec_length)
% tests the algorithm accuracy
% for meaningful results each file in the 'samples' directory must have a
% corresponding file in the 'database' directory with the same filename
% (without extension)
    disp('Loading data...')
    load('params.mat')
    mksqlite('open', 'db.sqlite');

    listing = dir('samples');
    n = size(listing, 1);
    i = 1;
    for k = 1:n
        filename = listing(k).name;
        if strcmp(filename, '.') || strcmp(filename, '..')
            continue
        end
        disp(['Testing ' filename]);
        y = load_audio(['samples/' filename], sample_rate);

        for j=1:rec_length
            result = identification(y(1:sample_rate*j), sample_rate, window_size, peak_radius, fanout_size);
            R(i,j) = strcmp(split_filename(filename), split_filename(result));
        end
%         R(i,:)
        i = i + 1;
    end
    mksqlite('close')

    plot(1:rec_length, mean(R, 1))
    xlabel('Length in seconds')
    ylabel('Accuracy')
end

