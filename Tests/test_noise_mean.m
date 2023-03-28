% test rumore e spettro medio del rumore

import ../Functions/.*;
addpath '../Functions';

file_sign1 = "../../Run21/C2.mat";
file_noise = "../../Run29/C2.mat";

k = 1;
noise = open(file_noise);
t = noise.x2(:, k);

if (mean(noise.y2(1:1000, k)) > 0)
    s = noise.y2(:, k) - abs(mean(noise.y2(1:1000, k)));
else
    s = noise.y2(:, k) + abs(mean(noise.y2(1:1000, k)));
end
figure
plot(t, s);

s_ft_noise = [];
s_noise = [];
[rows, cols] = size(noise.y2);

for i = 1:1:cols
    t = noise.x2(:,i);

    if (mean(noise.y2(1:1000,i)) > 0)
        s = noise.y2(:,i) - abs(mean(noise.y2(1:1000,i)));
    else
        s = noise.y2(:,i) + abs(mean(noise.y2(1:1000,i)));
    end

    [s_ft, f] = fourier_transform(t, s);
    s_ft_noise = [s_ft_noise, s_ft];
end

s_ft_noise_mean = mean(s_ft_noise, 2);
figure
plot(f, s_ft_noise_mean)


