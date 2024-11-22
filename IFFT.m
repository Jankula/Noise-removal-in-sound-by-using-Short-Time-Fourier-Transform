%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Short-Time Fourier Transform            %
%               with MATLAB Implementation             %
%                                                      %
% Author: Nikola Jankulovic                  22/1/2023 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function X = IFFT(Y, n)

Y = Y(1 : n);

W = exp(1i*2*pi/n);
F = W.^((0 : n-1)' * (0 : n-1));

X = conj(F)*Y / n;

end