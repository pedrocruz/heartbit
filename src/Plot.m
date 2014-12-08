% Trabalho de Telecomunicacoes
% Pedro Cruz
% Thiago Barroso Perrotta

% Names of the files that will be used
data = ['Data\100.mat', 'Data\101.mat', 'Data\102.mat' ...
    'Data\103.mat', 'Data\104.mat', 'Data\105.mat' ...
    'Data\106.mat', 'Data\107.mat', 'Data\108.mat' ...
    'Data\109.mat', 'Data\111.mat', 'Data\112.mat' ...
    'Data\113.mat', 'Data\114.mat', 'Data\115.mat' ...
    'Data\116.mat', 'Data\117.mat', 'Data\118.mat' ...
    'Data\119.mat', 'Data\121.mat', 'Data\122.mat' ...
    'Data\123.mat', 'Data\124.mat', 'Data\200.mat' ...
    'Data\201.mat', 'Data\202.mat', 'Data\203.mat' ...
    'Data\205.mat', 'Data\207.mat', 'Data\208.mat'];

diag = ['Supraventricular ectopy', 'Supraventricular ectopy', 'Ventricular ectopy'...
   'Supraventricular ectopy', 'Ventricular ectopy', 'Ventricular ectopy'...
   'Ventricular ectopy', 'Ventricular ectopy', 'Supraventricular ectopy'...
   'Ventricular ectopy', 'Normal', 'Supraventricular ectopy' ...
   'Supraventricular ectopy', 'Supraventricular ectopy', 'Normal' ...
   'Ventricular ectopy', 'Normal', 'Supraventricular ectopy' ...
   'Ventricular ectopy', 'Normal', 'Normal' ...
   'Ventricular ectopy', 'Ventricular ectopy', 'Ventricular ectopy' ...
   'Supraventricular ectopy', 'Supraventricular ectopy', 'Ventricular ectopy' ...
   'Ventricular ectopy', 'Ventricular ectopy', 'Ventricular ectopy'];
% Load data to the 'val' Matrix.
load 'Data\102m.mat'

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
title('F\{dECG\}')

HdECG = imag(hilbert(dECG));% taking the Hilbert transform of the signal
subplot (totalPlots, 1, 4); % fourth subplot
plot(t, HdECG);             % plotting the Hilbert transform
title('H\{dECG\}')

BdECG = abs(hilbert(dECG)); % CReating the envelope
subplot (totalPlots, 1, 5); % fifth subplot
plot(t, BdECG);             % plotting the envelope of Hilbert transform
title('Envelope\{dECG\}')

% http://www.ehow.com.br/detectar-pico-matlab-como_33112/
menor = min(BdECG);
maior = max(BdECG);
media = (menor + maior) / 2.0;
[peak_value, peak_location] = findpeaks(BdECG,'minpeakheight',media);




fid = fopen('variances.txt','wt');  % Note the 'wt' for writing in text mode
fprintf(fid,'%f\n',a);  % The format string is applied to each element of a
fclose(fid);
