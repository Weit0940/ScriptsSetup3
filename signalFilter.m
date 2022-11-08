
function [y_signal_filt] = signalFilter(run19, y_noise, x_noise, j)

y_signal = run19.y2(:,j);
x_signal = run19.x2(:,j);

L = length(x_noise);
Fs = 1 / (x_noise(2) - x_noise(1));
f = Fs * (0:(L/2)) / L;
fty_noise = ft(y_noise, L);

th = 10^(-6);
[ps] = findpeaks(fty_noise, f, 'MinPeakHeight', th);

if (~isempty(ps))
    Fs = 1 / (x_signal(2) - x_signal(1));
    f_coff = min(ps);
    d = designfilt('lowpassfir', 'FilterOrder', 10, 'CutoffFrequency', f_coff, 'SampleRate', Fs);
    y_signal_filt = filter(d, y_signal);
else
    y_signal_filt = y_signal;
end

end

function [fty] = ft(y, L)

fty = fft(y);
fty = abs(fty).^2;
fty = fty(1:(L/2+1));

end