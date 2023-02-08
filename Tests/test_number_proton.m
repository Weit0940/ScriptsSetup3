
import ../Functions/.*;
addpath '../Functions';

file_sign1 = "../../Run21/C2.mat";
file_noise = "../../Run29/C2.mat";

e = 1.6e-19;
imp = 50;
delta = 2.001e-6;
dE_dx = 6.6*10^6; %MeV cm^2/g
rho_sil = 3.74; % g/cm^3
w_sil = 3; %eV
dx_sil = 1e-6; %m

th1 = 0.6;
th2 = 0.1;
fcoff = 199998;

c2 = open(file_sign1);
[rows, cols] = size(c2.y2);

noise = open(file_noise);
x_noise = mean(noise.x2(:, 1:150), 2);
y_noise = mean(noise.y2(:, 1:150), 2);
y_noise_filter = signal_filter(x_noise, y_noise, fcoff);
y_noise_bias = mean(y_noise_filter);

n_couple_list = zeros(cols, 1);

for i=1:1:cols
    c2_x = c2.x2(:, i);
    c2_y = c2.y2(:, i);
    c2_y_filt = signal_filter(c2_x, c2_y, fcoff) - min(signal_filter(c2_x, c2_y, fcoff)) - y_noise_bias;

    q = trapz(c2_x, c2_y_filt) / imp;
    n_couple_list(i) = q / e;
end

histogram(n_couple_list, 125)

n_couple = mean(n_couple_list);
n_proton = n_couple / (dE_dx * dx_sil / w_sil);

n_proton_th = 30e-6 * delta / e;
n_couple_th = n_proton_th * (dE_dx * dx_sil / w_sil);





