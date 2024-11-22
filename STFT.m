%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Short-Time Fourier Transform            %
%               with MATLAB Implementation             %
%                                                      %
% Author: Nikola Jankulovic                  22/1/2023 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [W,t,f] = STFT(X,Win,Hop,fs)

%  X - signal (Should be a power of 2!)
%  f - frequency vector, Hz
%  t - time vector, s
%  Win - window function
%  Hop - number of frames to slide the window (Should be a factor of n!)
%  fs - frames per second
%  xlen - number od frames of X
%  N - total number of frames (length of X padded to the nearest power of 2)
%  n - number of frames in the window
%  W - matrix of STFT complex coefficients
%  L - number of windows when sliding
%  xw - X signal windowed



xlen = length(X);
N = 1;
while N < xlen
    N = N*2;
end

n = length(Win);
L = fix((N-n)/Hop);

% preallocating space for the STFT matrix
W = zeros(n,L);

% padding the signal X to the power of 2 (N)
X = padarray(X,[N-xlen,0],0,'post');


for i = 0 : (L-1)
    xw = X(1 + i*Hop : i*Hop + n).*Win;
    F = fft(xw,n);
    W(:,i+1) = F(1:n);
end

% Cutting the padded part of X
t = (n/2 : Hop : xlen) / fs;

% Getting rid of double sided frequencies
if rem(n, 2)                     % odd nfft excludes Nyquist point
   f = (0 : (n+1)/2 - 1) * fs / n;
else                             % even nfft includes Nyquist point
   f = (0 : n/2 - 1) * fs / n;
end

end