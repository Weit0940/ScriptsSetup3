
file_noise = "../Run29/C2.mat";
file_sign = "../Run19/C2.mat";

run29 = open(file_noise);
run19 = open(file_sign);

y_noise = mean(run29.y2(:,1:150)');
x_noise = mean(run29.x2(:,1:150)');

[rows, cols] = size(run19.y2);
peaks = [];
locs = [];
widths =[];
proms = [];
pksarea = [];
t = [];

for i=1:1:cols

    X = run19.x2(:,i);
    Y = signalFilter(run19, y_noise, x_noise, i);

    [pks,ls,ps] = findpeaks(Y, X, 'MinPeakHeight', 0.015);

    if (~isempty(pks))
        for j = 1:1:length(pks)

            peaks = [peaks, 0];
            peaks = [peaks, pks(j)];
            peaks = [peaks, 0];

            DY = diff(Y);
            index = find(Y == pks(j));

            for k = 1:1:length(index)
                index_r = index(k);
                while(DY(index_r) < 0)
                    index_r = index_r + 1;
                end

                index_l = index(k);
                while(DY(index_l - 1) > 0)
                    index_l = index_l - 1;
                end

                t = [t, X(index_l - 1)];
                t = [t, ls(j)];
                t = [t, X(index_r)];

                width = abs(X(index_l - 1) - X(index_r));
                widths = [widths, width];

                area = trapz(X(index_l - 1:index_r), Y(index_l - 1:index_r));
                pksarea = [pksarea, area];
            end

            %locs = [locs, ls(j)];
        end
    end
end


figure
plot(t, peaks, 'b--o')
hold on
plot(t, zeros(length(t),1), 'r--x')

figure
peaks1 = nonzeros(peaks);
hpk = histogram(peaks1, 250);
title('Histogram PeaksHeight')
hold on
plot(hpk.BinEdges(1:length(hpk.BinEdges) - 1) + hpk.BinWidth/2, hpk.BinCounts, '-r', 'LineWidth', 2)

% figure
% hlocs = histogram(locs, 250);
% title('Histogram PeaksLocation')
% hold on
% plot(hlocs.BinEdges(1:length(hlocs.BinEdges) - 1) + hlocs.BinWidth/2, hlocs.BinCounts, '-r', 'LineWidth', 2)

figure
hw = histogram(widths, 250);
title('Histogram PeaksWidth')
hold on
plot(hw.BinEdges(1:length(hw.BinEdges) - 1) + hw.BinWidth/2, hw.BinCounts, '-r', 'LineWidth', 2)

figure
hpr = histogram(pksarea, 250);
title('Histogram PeaksArea')
hold on
plot(hpr.BinEdges(1:length(hpr.BinEdges) - 1) + hpr.BinWidth/2, hpr.BinCounts, '-r', 'LineWidth', 2)






