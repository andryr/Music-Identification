function [M] = create_db(varargin)
% creates the database
    Defaults = {44100, 4096, 20, 15};
    Defaults(1:nargin) = varargin;
    [sample_rate, window_size, peak_radius, fanout_size] = Defaults{:};
    
    mksqlite('open', 'db.sqlite');
    try
        mksqlite('DROP TABLE fingerprints');
        mksqlite('DROP TABLE songs');
    end
    mksqlite('CREATE TABLE songs (id integer primary key, name varchar not null)');
    mksqlite('CREATE TABLE fingerprints (hash varchar not null, song_id integer not null, song_time integer not null, unique(hash, song_id, song_time))');
    mksqlite('CREATE INDEX idx_fingerprints_hash ON fingerprints(hash)');
    mksqlite('CREATE INDEX idx_fingerprints_song_id ON fingerprints(song_id)');
    
    w = hamming(window_size);
    listing = dir('database');
    n = size(listing, 1);
    id = 0;
    mksqlite( 'begin' ); % all inserts are done in one single transaction
    for i = 1:n
        filename = listing(i).name;
        if strcmp(filename, '.') || strcmp(filename, '..')
            continue
        end
        mksqlite( 'INSERT INTO songs VALUES (?,?)', {id, filename} );
        fprintf('Création des hashes pour %s\n', filename);
        y = load_audio(['database/' filename], sample_rate);r
        S = spectrogram(y, w);
        P = peaks(abs(S), peak_radius); 
        H = generate_hashes(P, fanout_size);
        
        for j = 1:size(H, 1)
           mksqlite( 'INSERT INTO fingerprints VALUES (?,?,?)', {H{j, 1}, id ,H{j, 2}});
        end
        fprintf('Nombre de hashs créés : %d\n', size(H, 1));
        id = id + 1;
    end
    mksqlite( 'commit' );
    mksqlite('close');
	save('params.mat', 'sample_rate', 'window_size', 'peak_radius', 'fanout_size'); % on sauvegarde les paramètres, car il faudra utiliser les mêmes pour l'identification
end