% stima del numero medio di coppie e-l generate dal fascio

import ../Functions/.*;
addpath '../Functions';

% Fascio 102MeV
file_sign1 = "../../Run21/C2.mat";

e = 1.6e-19;
imp = 50;
delta = 2.001e-6;
dE_dx = 6.6*10^6; %MeV cm^2/g
rho_sil = 3.74; % g/cm^3
w_sil = 3; %eV
dx_sil = 1e-6; %m

fcoff = 199998;

c2 = open(file_sign1);
[rows, cols] = size(c2.y2);

n_couple_list = zeros(cols, 1);

for i=1:1:cols
    c2_x = c2.x2(:, i);
    c2_y = c2.y2(:, i) + abs(mean(c2.y2(1:1000, i)));
    c2_y_filt = signal_filter(c2_x, c2_y, fcoff);

    q = trapz(c2_x, c2_y_filt) / imp;
    n_couple_list(i) = q / e;
end

histogram(n_couple_list, 100)

histogram(n_couple_list * e, 100)

n_couple = mean(n_couple_list);
n_proton = n_couple / ((dE_dx * rho_sil * dx_sil * 100) / w_sil);

n_proton_th = 30e-6 * delta / e;
n_couple_th = n_proton_th * ((dE_dx * rho_sil *  dx_sil * 100) / w_sil);





