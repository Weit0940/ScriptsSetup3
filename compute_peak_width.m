
% calculate the peak width and the start and end points
function [peak_width, t_peak_start, t_peak_end, area] = compute_peak_width(X, Y, peak, index)

index_r = index;
while(Y(index_r) >= 0.1*Y(index))
    index_r = index_r + 1;
end

index_l = index;
while(Y(index_l) >= 0.1*Y(index))
    index_l = index_l - 1;
end

t_peak_start = X(index_l);
t_peak_end = X(index_r);
peak_width = abs(X(index_l) - X(index_r));

area = trapz(X(index_l - 1:index_r), Y(index_l - 1:index_r));

end