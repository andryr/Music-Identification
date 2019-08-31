function record_samples(rec_length)
% helper function to record samples
% record a sample of length rec_length seconds for each file of the
% 'database' directory
% samples are saved in the 'samples' directory
    listing = dir('database');
    n = size(listing, 1);
    for i = 1:n
        filename = listing(i).name;
        if strcmp(filename, '.') || strcmp(filename, '..')
            continue
        end
        disp(['Chargement de ' filename]);
        [y, s_r] = audioread(['database/' filename]);
        length = s_r*rec_length;
        if length > size(y,1)
            continue % le morceau est trop court
        end
        start = randi(size(y,1) - length + 1);
        y = y(start:start + length - 1);
        recObj = audiorecorder(44100, 16, 2);
        player = audioplayer(y, s_r);
        play(player);
        disp(['Début enregistrement de ' filename]);
        recordblocking(recObj, rec_length);
        disp('Fin de l''enregistrement');
        stop(player);
        y = getaudiodata(recObj);
        audiowrite(['samples/' split_filename(filename) '.ogg'], y, 44100);

    end
end
    