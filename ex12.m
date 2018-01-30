f = fopen('iq-fm-96M-240k.dat', 'r', 'ieee-le');
c = fread(f, [2,inf], '*float32');
fclose(f);
z = c(1,:) + j*c(2,:);

s = diff(unwrap(angle(z)))/(2*pi);

myFilter = butter(6, 16000/(2*length(s)));
x = filter(myFilter(1), myFilter(2), s);

y = x(5:5:end);
length(y)
normalised = y/max(y);

audiowrite('outputRadio.wav', normalised, 48000);