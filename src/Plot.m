load ('100m.mat')          % the signal will be loaded to "val" matrix
val = (val - 1024)/200;     % you have to remove "base" and "gain"
ECG = val(1,1:1000);        % select the lead (Lead I)
Fs = 360;                   % sampling frequecy
t = (0:length(ECG)-1)/Fs;   % creatin the time array
plot(t,ECG)                 % plotting the signal
dECG = zeros(size(ECG));    % starting an array to store ECG's derivative
halfF = Fs/2;               % this will be used to calculate dECG
disp(halfF);
for i = 2:(size(ECG)-1)
    dECG(i) = (halfF) * (ECG(i-1) - ECG(i+1));
end
plot(t, ECG, t, dECG);
    