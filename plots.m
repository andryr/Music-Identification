% just some garbage code that was used to run some tests and draw some
% plots

% [y, s_r] = audioread('samples/piano_G.wav');
% t = linspace(0, size(y, 1)/s_r, size(y, 1));
% 
% figure;
% plot(t, y)
% xlabel('Temps')
% 
% Y = fft(y(44100:44100 + 2048)); % décalage d'une seconde pour prendre la partie à peu près périodique
% figure;
% stem(abs(Y(1:100)));
% ylabel('Amplitude')
% xlabel('Fréquence')
load('params.mat')
w = hamming(window_size);
y = load_audio('database/dream_lantern.mp3', sample_rate);
figure
spectrogram(y, w, 'yaxis')
xlabel('Échantillons')
ylabel('Fréquence normalisée')

S = abs(spectrogram(y, w));
% figure
% imshow(S)
% xticks(linspace(1,size(S,1)))
% xlabel('Temps')
% ylabel('Bande de fréquence')

P = peaks(abs(S), peak_radius);
figure
[Y X] = find(P);
X = window_size*X;
Y = (2/window_size)*Y;
scatter(X,Y)
scatter(X,Y, '+')
axis([0 max(X)+1 0 1])
xlabel('Échantillons')
ylabel('Fréquence normalisée')
% S = abs(log_spectrogram(y, sample_rate, window_size));
% 
% M = S(1:end,1:end);
% figure
% imshow(M)

% y = load_audio('samples/zenzensense.ogg', sample_rate);
% S = abs(log_spectrogram(y, sample_rate, window_size));
% 
% M = S(1:end,1:50);
% figure
% imshow(M)

% nhood = ones(peak_radius * 2 + 1, peak_radius * 2 + 1);
% nhood(peak_radius+1,peak_radius+1) = 0;
% J = imdilate(M,nhood);
% P = peaks(M, peak_radius);
% figure
% spy(P)
% 
% se = strel('disk',8);
% J = imtophat(M,se);
% % figure
% % imshow(J)
% 
% % J = imdilate(J,nhood);
% % figure
% % imshow(J)
% Q = peaks(J, peak_radius);
% figure
% spy(Q)
% 
% figure
% spy(xor(P,Q))