%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Short-Time Fourier Transform            %
%               with MATLAB Implementation             %
%                                                      %
% Author: Nikola Jankulovic                  22/1/2023 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Plot_STFT(W, t, f, Win, tL)

% tL - Tiled layout to bind the plots

% Adjusting the double sided frequency (Nyquist frequency)
if rem(length(Win), 2)                     % odd nfft excludes Nyquist point
    W(2:end, :) = W(2:end, :).*2;
else                                       % even nfft includes Nyquist point
    W(2:end-1, :) = W(2:end-1, :).*2;
end

% Adjusting W to time vector t and freq vector f
W = W(1 : length(f), 1 : length(t)); 

% Plotting the spectogram

% Adjusting the color
n = length(Win);
C = sum(Win)/n; % calculate the coherent amplification of the window
W = abs(W)/n/C;
W = 20*log10(W + 1e-6); % convert amplitude spectrum to dB (min = -120 dB)


ax = nexttile;
ax.Parent = tL;

surf(ax, t, f, W)
shading interp
axis tight
view(0, 90)
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Frequency, Hz')
title(ax, 'Amplitude spectrogram of the signal')

hcol = colorbar;
set(hcol, 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel(hcol, 'Magnitude, dB')



end