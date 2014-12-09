function [ ] = simple_plot( file_name,number)
%SIMPLE_PLOT Summary of this function goes here
%   Detailed explanation goes here
    load (file_name);

    val = (val - 1024)/200;     % you have to remove "base" and "gain"
    ECG = val(1,1:1000);        % select the lead (Lead I)
    Fs = 360;                   % sampling frequecy
    t = (0:length(ECG)-1)/Fs;   % creatin the time array
    
    plot(t,ECG)                 % plotting the signal
    dECG = zeros(size(ECG));    % starting an array to store ECG's derivative
    halfF = Fs/2;               % this will be used to calculate dECG

    for i = 2:(length(ECG)-1)    % this loop calculates dECG
        dECG(i) = (halfF) * (ECG(i+1) - ECG(i-1));
    end
    
    BdECG = abs(hilbert(dECG)); % Creating the envelope
    minimum = min(BdECG);
    maximum = max(BdECG);
    range = (minimum + maximum);
    rangedBdECG = BdECG/range;
    
    h=figure('visible', 'off');
    plot(t, ECG, 'k', t, rangedBdECG, 'b'); 
    saveas(h,sprintf('Output/output%d.jpg',number), 'png');

end

