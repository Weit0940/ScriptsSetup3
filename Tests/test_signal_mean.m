import Functions/.*;
addpath 'Functions';

file_sign1 = "../Run21/C2.mat";
file_noise = "../Run29/C2.mat";

noise = open(file_noise);
s_noise = mean(noise.y2, 2);
t_noise = mean(noise.x2, 2);
figure
plot(t_noise, s_noise)
s_noise_filt = signal_filter(t_noise, s_noise, 199998);
figure
plot(t_noise, s_noise_filt)

c2 = open(file_sign1);
[rows, cols] = size(c2.y2);
s = mean(c2.y2, 2);
t = mean(c2.x2, 2);

s_filt = signal_filter(t, s, 199998);
s_filt = s_filt - mode(s_filt) - mean(s_noise_filt);
figure
plot(t, s_filt)

e = 1.6e-19;
imp = 50;
w = 3;
E = 6.6 * 3.74 * 30000;
q = trapz(t, s_filt) / imp;
n = (q / e) / (E/w);

