function [result] = identification(y, sample_rate, window_size, peak_radius, fanout_size)
% identifies the piece from where y is extracted (y must be a vector of
% samples)
    w = hamming(window_size);
    S = spectrogram(y, w);
    P = peaks(abs(S), peak_radius);
    H = generate_hashes(P, fanout_size);

    matches = containers.Map;
    for i= 1:size(H,1) % match each piece with its delta_t list
        h = H(i,:);
        hash = h{1};
        sample_t = h{2};
        [res, res_count] = mksqlite('SELECT * FROM fingerprints LEFT JOIN songs ON song_id = songs.id WHERE hash=?', hash);     
        for j = 1:res_count
            db_t = res.song_time;
            db_id = res.name; % piece identifiers are their filename
            delta_t = db_t - sample_t;
            add_entry(matches, db_id, delta_t);
        end
    end


    key_set = keys(matches); % key_set contains the name of the pieces that have at least one hash in common with y
    max_align = 0;
    max_align_key = '';
    for i = 1:size(key_set, 2) % iterate over key_set and keep the piece that is the most "time coherent" with y
       key = key_set{i};
       L = matches(key); % L = list of delta_t
       edges = sort(unique(L));
       edges(end+1) = edges(end) + 1;
       H_L = histcounts(L, edges); % count the number of occurences of each delta_t
       max_h = max(H_L);
       if max_h > max_align
           max_align = max_h;
           max_align_key = key;
       end
    end
    
    result = max_align_key;
    
end