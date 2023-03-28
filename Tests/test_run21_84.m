
import ../Functions/.*;
addpath '../Functions';

file_sign = "../../Run21/C2.mat";

i = 1;
signal = open(file_sign);
x_signal = signal.x2(:, i);
y_signal = signal.y2(:, i) + abs(mean(signal.y2(1:1000, i)));
if (true)
    figure
    plot(x_signal, y_signal)
end

[ft_y_signal, f_signal] = fourier_transform(x_signal, y_signal);
% figure
% plot(f_signal, ft_y_signal)

[y_signal_filter] = signal_filter(x_signal, y_signal, 199998);
figure
if (true)
    plot(x_signal, y_signal_filter, 'b')
    hold on
end

th1 = 0.004;
th2 = 0.004;

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

