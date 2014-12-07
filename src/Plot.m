% Trabalho de Telecomunicações
% Pedro Cruz
% Thiago Barroso Perrotta

% Load data to the 'val' Matrix.
load '100m.mat'

% The total of graphics to be plotted.
totalPlots = 5;

val = (val - 1024)/200;     % you have to remove "base" and "gain"
ECG = val(1,1:1000);        % select the lead (Lead I)
Fs = 360;                   % sampling frequecy
t = (0:length(ECG)-1)/Fs;   % creatin the time array

figure                      % create new figure
subplot(totalPlots,1,1)     % first subplot
plot(t,ECG)                 % plotting the signal
title('ECG')
dECG = zeros(size(ECG));    % starting an array to store ECG's derivative
halfF = Fs/2;               % this will be used to calculate dECG

disp(['time interval = ', num2str(halfF)]);
disp(['size(ECG) = ', num2str(size(ECG))]);

for i = 2:(length(ECG)-1)    % this loop calculates dECG
    dECG(i) = (halfF) * (ECG(i+1) - ECG(i-1));
end
subplot(totalPlots,1,2)     % second subplot
plot(t, dECG);              % plotting dECG
title('dECG')               % adding a title to the graphic

FdECG = fft(dECG);          % getting the fourier transform of dECG
f = (0:length(FdECG)-1)*Fs/length(ECG);
subplot(totalPlots,1,3);    % third subplot
plot(f, real(FdECG));       % plotting the fourier transform of dECG
title('F{dECG}')

HdECG = imag(hilbert(dECG));% taking the Hilbert transform of the signal
subplot (totalPlots, 1, 4); % fourth subplot
plot(t, HdECG);             % plotting the Hilbert transform

BdECG = abs(hilbert(dECG)); % CReating the envelope
subplot (totalPlots, 1, 5); % fifth subplot
plot(t, BdECG);             % plotting the envelope of Hilbert transform

% http://www.ehow.com.br/detectar-pico-matlab-como_33112/
menor = min(BdECG);
maior = max(BdECG);
media = (menor + maior) / 2.0;
[peak_value, peak_location] = findpeaks(BdECG,'minpeakheight',media);
