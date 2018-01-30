f = fopen('iq-fm-97M-3.6M.dat', 'r', 'ieee-le');
c = fread(f, [2,inf], '*float32');
fclose(f);
z = c(1,:) + j*c(2,:);

spectrogram(z);

shifted = 0:length(z)-1;
for i = 1:length(z)
    shifted(i) = z(i) * exp((2 * pi * shifted(i) * j * 1000000) / 3600000);
end

%spectrogram(shifted);

[b,a] = butter(6, 200000/(3600000/2))
filtered = filter(b, a, shifted);

%spectrogram(filtered);

%FM demodulate
s = diff(unwrap(angle(filtered)))/(2*pi);

%low pass filter
[b,a] = butter(6, 16000/(3600000/2));
x = filter(b, a, s);

y = x(75:75:end);
normalised = y/max(y);

audiowrite('outputRadio2.wav', normalised, 48000);
