% Author:       Stefan Stark
% Date:         11.11.2016
% Description:  File to calcualte spectrum apmplitudes with the goertzel
%               Algorithmus

% lecturer slides 06_Selected_Algorithms
% v[n] = x[n] + a * v[n-1] - v[n-2]
% y_k[n] = v[n] - v[n-1] * Wn

function [Y] = my_goertzel(signal, freq)

for n = 1:length(freq)
    k = freq(n);                    % withaut rounding result is more
                                    % to the solution?
    a = 2*pi/length(signal)*k;      % constant used for calc Wn and coeff
    Wn = exp(-j*a);
    coeff = 2*cos(a);

    vn = 0;                         %v[n], reset
    vn1 = 0;                        %v[n-1], reset
    vn2 = 0;                        %v[n-2], reset

    % v[n] looop
    for i = 1:length(signal)
        vn = signal(i) + coeff * vn1 - vn2;
        vn2 = vn1;
        vn1 = vn;
    end
    vn = coeff * vn1 - vn2;
    Y(n) = vn - vn1*Wn;
end

end


