%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Short-Time Fourier Transform            %
%               with MATLAB Implementation             %
%                                                      %
% Author: Nikola Jankulovic                  22/1/2023 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X, fs] = audioread('noisy_1.wav');


%--------------variables to change---------------
wlen = 2048;                      % window length (recomended to be power of 2)
hop = wlen;                       % hop size (recomended to be power of 2)
win = hamming(wlen, 'periodic');  % window function that we use (can not have zeros in it self!)


Finesse = -30; %(dB)
%------------------------------------------------
xlen = length(X); 


[W,t,f] = STFT(X, win, hop, fs);
W1 = Extract(W, win, Finesse);
X1 = ISTFT(W1, win, hop, xlen);


% Showing the difference before and after the noise removal

fig = figure('Name','Extraction');
fig.Color = "#bd5d63";
fig.WindowState = "maximized";

tL = tiledlayout(2,2);
tL.Parent = fig;


% Original signal
ax5 = nexttile;
plot(ax5, 1 : xlen, X, 'b')
title(ax5, 'X before');

% Signal after
ax6 = nexttile;
plot(ax6, 1 : xlen, X1, 'Color', '#EDB120');
title(ax6, 'X after');

% Spectrogram of X
Plot_STFT(W, t, f, win, tL);

% Spectrogram after
Plot_STFT(W1, t, f, win, tL);

% Playing the sound
%sound(X,fs)
sound(X1(1:(7*fs)),fs)
