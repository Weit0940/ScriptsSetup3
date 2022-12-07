

file_noise = "../Run29/C2.mat";
file_sign = "../Run21/C2.mat";

noise = open(file_noise);
data = open(file_sign);

y_noise = mean(noise.y2(:,:)');
x_noise = mean(noise.x2(:,:)');

i = randsample(529,1)

x_signal = data.x2(:,i);
y_signal = signal_filter(data, y_noise, x_noise, i);

figure
plot(x_signal, data.y2(:,i));

figure
plot(x_signal, y_signal);

