%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Short-Time Fourier Transform            %
%               with MATLAB Implementation             %
%                                                      %
% Author: Nikola Jankulovic                  22/1/2023 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
function Y = FFT(X, n)

% X - Signal
% n - first n frames to apply the fft
% xlen - length of X

[a,b] = size(X);
xlen = length(X);

if n > xlen
   error("n can not be bigger than the length of X!")
end

if a ~= 1 && b ~= 1
   error("X is not a vector!")
end

if b ~= 1
   X = X';
end

X1 = X(1 : n);

% Making sure that n is the power of 2
i = 1;
while i < n
   i = i*2;
end

if n < i
   % Padding vector X1 with zeroes
   X1(n+1 : i) = zeros(i-n, 1);
end

Y = FFT_recursive(X1);

end