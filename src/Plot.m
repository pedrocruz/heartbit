load ('100m.mat')           % the signal will be loaded to "val" matrix
val = (val - 1024)/200;     % you have to remove "base" and "gain"
ECG = val(1,1:1000);        % select the lead (Lead I)
Fs = 360;                   % sampling frequecy
t = (0:length(ECG)-1)/Fs;   % creatin the time array

figure                      % create new figure
subplot(2,1,1)              % first subplot
plot(t,ECG)                % plotting the signal
title('ECG')
dECG = zeros(size(ECG));    % starting an array to store ECG's derivative
halfF = Fs/2;               % this will be used to calculate dECG

disp(['time interval = ', num2str(halfF)]);
disp(['size(ECG) = ', num2str(size(ECG))]);

sizeECG = size(ECG);
for i = 2:(sizeECG(2)-1)    % this loop calculates dECG
    dECG(i) = (halfF) * (ECG(i+1) - ECG(i-1));
    disp(['ECG(i-1) = ', num2str(ECG(i-1)), 'ECG(i+1)',num2str(ECG(i+1))]);
end
subplot(2,1,2)              % second subplot
plot(t, dECG);
title('dECG')
    