
file_sign = "../Run21/C2.mat";
th1 = 0.0005;
th2 = 0.002;
fcoff = 199998;

signal = open(file_sign);

[rows, cols] = size(signal.y2);
peaks = [];
peaks_widths =[];
peaks_area = [];
t_peaks = [];

figure
for i=1:1:cols
    x = signal.x2(:,i);
    y = signal.y2(:, i);
    y_filter = signal_filter(x, y, fcoff);
    [pks] = findpeaks(y_filter, x, 'MinPeakProminence', th1, 'MinPeakHeight', th2);
    if (~isempty(pks))
        for j = 1:1:length(pks)
            index = find(y_filter == pks(j));
            for k = 1:1:length(index)
                [width, start_point, end_point, area] = compute_peak_width(x, y_filter, diff(y_filter), index(k));
                peaks_widths = [peaks_widths, width];

                t_peaks =[t_peaks, start_point];
                t_peaks =[t_peaks, x(index(k))];
                t_peaks =[t_peaks, end_point];

                peaks = [peaks, 0];
                peaks = [peaks, pks(j)];
                peaks = [peaks, 0];

                plot(t_peaks, peaks,'marker','o')

                peaks_area = [peaks_area, area];
            end
        end
    end
end

figure
peaks1 = nonzeros(peaks);
hpk = histogram(peaks1, 200);
title('Histogram PeaksHeight')
hold on
plot(hpk.BinEdges(1:length(hpk.BinEdges) - 1) + hpk.BinWidth/2, hpk.BinCounts, '-r', 'LineWidth', 2)

figure
hw = histogram(peaks_widths, 200);
title('Histogram PeaksWidth')
hold on
plot(hw.BinEdges(1:length(hw.BinEdges) - 1) + hw.BinWidth/2, hw.BinCounts, '-r', 'LineWidth', 2)

figure
hpr = histogram(peaks_area, 200);
title('Histogram PeaksArea')
hold on
plot(hpr.BinEdges(1:length(hpr.BinEdges) - 1) + hpr.BinWidth/2, hpr.BinCounts, '-r', 'LineWidth', 2)



