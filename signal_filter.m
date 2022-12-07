function [y_signal_filt] = signal_filter(run, y_noise, x_noise, j)

y_signal = run.y2(:,j);
x_signal = run.x2(:,j);

L = length(x_noise);
M = L/2 + 1;
Fs = 1 / (x_noise(2) - x_noise(1));
f = Fs * (1:M) ./ L;
fty_noise = ft(y_noise, M);

plot(f./10^9, fty_noise)

th = 1;
[ps] = findpeaks(fty_noise, f, 'MinPeakHeight', th);

Fs = 1 / (x_signal(2) - x_signal(1));
f_coff = max(ps);
d = designfilt('lowpassfir', 'FilterOrder', 20, 'CutoffFrequency', f_coff, 'SampleRate', Fs);
y_signal_filt = filter(d, y_signal);

end

function [fty] = ft(y, M)

fty = fft(y);
fty = abs(fty);
fty = fty(1:M);

end