
import ../Functions/.*;
addpath '../Functions';

file_noise = "../../Run29/C2.mat";
file_sign = "../../Run21/C2.mat";

noise = open(file_noise);
x_noise = mean(noise.x2(:, 1:150), 2);
y_noise = mean(noise.y2(:, 1:150), 2);
if (false)
    figure
    plot(x_noise, y_noise)
end

[ft_y_noise, f_noise] = fourier_transform(x_noise, y_noise);
if (false)
    figure
    plot(f_noise, ft_y_noise)
end


[y_noise_filter] = signal_filter(x_noise, y_noise, 199998);
if (false)
    figure
    plot(x_noise, y_noise_filter)
end

i = 1;
signal = open(file_sign);
x_signal = signal.x2(:, i);
y_signal = signal.y2(:, i) - mean(y_noise_filter);
if (false)
    figure
    plot(x_signal, y_signal)
end

[ft_y_signal, f_signal] = fourier_transform(x_signal, y_signal);
% figure
% plot(f_signal, ft_y_signal)

[y_signal_filter] = signal_filter(x_signal, y_signal, 199998);
figure
if (false)
    plot(x_signal, y_signal_filter, 'b')
    hold on
end

th1 = 0.006;
th2 = 0.007;

yline(th2, 'r');
hold on

findpeaks(y_signal_filter, x_signal, 'MinPeakProminence', th1, 'MinPeakHeight', th2, 'Annotate','extents');
[pks, locs, w, prom] = findpeaks(y_signal_filter, x_signal, 'MinPeakProminence', th1, 'MinPeakHeight', th2);

peaks = [];
peaks_widths =[];
peaks_area = [];
t_peaks = [];

figure
for i = 1:1:length(pks)
    index = find(y_signal_filter == pks(i));
    [width, start_point, end_point, area] = compute_peak_width(x_signal, y_signal_filter, diff(y_signal_filter), index);

    peaks_widths = [peaks_widths, width];

    t_peaks =[t_peaks, start_point];
    t_peaks =[t_peaks, locs(i)];
    t_peaks =[t_peaks, end_point];

    peaks = [peaks, 0];
    peaks = [peaks, pks(i)];
    peaks = [peaks, 0];

    plot(t_peaks, peaks,'marker','o')

    peaks_area = [peaks_area, area];
end

