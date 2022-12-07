function main(threshold)

file_noise = "../Run29/C2.mat";
file_sign = "../Run21/C2.mat";

noise = open(file_noise);
data = open(file_sign);

y_noise = mean(noise.y2(:,1:150)');
x_noise = mean(noise.x2(:,1:150)');

[rows, cols] = size(data.y2);
peaks = [];
peaks_widths =[];
peaks_area = [];
t_peaks = [];

figure
for i=1:1:cols
    X = data.x2(:,i);
    Y = signal_filter(data, y_noise, x_noise, i);
    [pks] = findpeaks(Y, X, 'MinPeakHeight', threshold);
    if (~isempty(pks))
        for j = 1:1:length(pks)
            index = find(Y == pks(j));
            for k = 1:1:length(index)
                [width, start_point, end_point, area] = compute_peak_width(X, Y, pks(j), index(k));
                peaks_widths = [peaks_widths, width];

                t_peaks =[t_peaks, start_point];
                t_peaks =[t_peaks, X(index(k))];
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
hpk = histogram(peaks1, 250);
title('Histogram PeaksHeight')
hold on
plot(hpk.BinEdges(1:length(hpk.BinEdges) - 1) + hpk.BinWidth/2, hpk.BinCounts, '-r', 'LineWidth', 2)

figure
hw = histogram(peaks_widths, 75);
title('Histogram PeaksWidth')
hold on
plot(hw.BinEdges(1:length(hw.BinEdges) - 1) + hw.BinWidth/2, hw.BinCounts, '-r', 'LineWidth', 2)

figure
hpr = histogram(peaks_area, 200);
title('Histogram PeaksArea')
hold on
plot(hpr.BinEdges(1:length(hpr.BinEdges) - 1) + hpr.BinWidth/2, hpr.BinCounts, '-r', 'LineWidth', 2)

end



