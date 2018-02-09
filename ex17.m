[y, Fs] = audioread('touchtone.wav');

b1 = fir1(1024, [684.5/(Fs/2),709.5/(Fs/2)]);
x1 = filter(b1, 1, y);

b2 = fir1(1024, [1332/(Fs/2),1360/(Fs/2)]);
x2 = filter(b2, 1, y);

%freqz(b,1)
figure;
plot(x2)
hold on
plot(x1)
hold off

%spectrogram(y, 1024);