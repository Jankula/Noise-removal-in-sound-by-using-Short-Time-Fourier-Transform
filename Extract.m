%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Short-Time Fourier Transform            %
%               with MATLAB Implementation             %
%                                                      %
% Author: Nikola Jankulovic                  22/1/2023 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function W = Extract(W, Win, Finesse)

% Finesse(dB) - How coarse or fine the extracion should be 
% (how high the amplitude of the frequencies that we extract should be)
% Spectogram matrix



% Adjusting the amplitude to decibels and putting it in matrix Y
Y = zeros(size(W));
n = length(Win);
C = sum(Win)/n; % calculate the coherent amplification of the window
Y = abs(W)/n/C;
Y = 20*log10(Y + 1e-6); % convert amplitude spectrum to dB (min = -120 dB)
L = size(W); L = L(2);

for(i = 1 : n)
    for(j = 1 : L)
        if(Y(i, j) < Finesse)
            W(i, j) = 0;
        end
    end
end

end