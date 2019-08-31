disp('Loading data...')
load('params.mat')
mksqlite('open', 'db.sqlite');

while 1
    path = input('Input the path of the sample to test ', 's');
    y = load_audio(path, sample_rate);
    identification(y, sample_rate, window_size, peak_radius, fanout_size)
    cont = input('Continue ? (y/n) [y] ', 's');
    if cont == 'n'
        break
    end
end
mksqlite('close')
