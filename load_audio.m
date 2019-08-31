function [y] = load_audio(path, sample_rate)
% helper function to load audio file
    [y, s_r] = audioread(path);
    y = sum(y, 2) / size(y, 2); % convert y from stereo to mono
    if s_r ~= sample_rate % resample y if need
        [p, q] = rat(sample_rate / s_r);
        y = resample(y, p, q);
    end
end