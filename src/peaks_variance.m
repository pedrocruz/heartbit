function peak_variance = peaks_variance( fileName )
%peak_variances Calculates the variance of the peaks of the signal data in file

    load (fileName);
    val = (val - 1024)/200;     % you have to remove "base" and "gain"
    ECG = val(1,1:1000);        % select the lead (Lead I)
    Fs = 360;                   % sampling frequecy
    t = (0:length(ECG)-1)/Fs;   % creatin the time array
    dECG = zeros(size(ECG));    % starting an array to store ECG's derivative
    halfF = Fs/2;               % this will be used to calculate dECG

    for i = 2:(length(ECG)-1)    % this loop calculates dECG
        dECG(i) = (halfF) * (ECG(i+1) - ECG(i-1));
    end
    BdECG = abs(hilbert(dECG)); % Creating the envelope
    
    minimum = min(BdECG);
    maximum = max(BdECG);
    mean = (minimum + maximum) / 2.0;
    [peak_value, peak_location] = findpeaks(BdECG,'minpeakheight',mean);
    
    peak_diff = zeros(size(peak_location));
    for i = 1:(length(peak_location)-1)
        peak_diff(i) = peak_location(i) - peak_location(i+1);
    end    
    peak_variance = var(peak_diff);
end

