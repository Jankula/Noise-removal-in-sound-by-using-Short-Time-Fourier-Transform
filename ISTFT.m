%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Short-Time Fourier Transform            %
%               with MATLAB Implementation             %
%                                                      %
% Author: Nikola Jankulovic                  22/1/2023 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function X = ISTFT(W,Win,Hop,xlen)

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

[~,L] = size(W);
n = length(Win);
X = zeros(L * Hop + n , 1);

% recovering small segments of X timed by a Win

Y = zeros(n,L);

for i = 1 : L
    Y(:,i) = ifft(W(:,i), n);
end


% dividing by a window
for i = 1 : L
    Y(:,i) = Y(:,i) ./ Win; % Window must not have 0 in itself; 
end

% Now we have parts of the original signal that overlap each other;
% Let's reconstruct the signal part by part!

for i = 1 : (L - 1)
    X(1 + (i - 1)*Hop : i*Hop) = Y(1 : Hop , i);
end

X((L - 1) * Hop + 1 : (L - 1) * Hop + length(Win)) = Y(1 : length(Win), L);


% Cutting X to xlen;
X = X(1:xlen);

end