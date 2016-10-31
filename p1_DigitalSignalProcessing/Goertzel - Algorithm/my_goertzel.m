function [Y] = my_goertzel(signal, freq)

N = length(signal);
Y = zeros(length(freq),1)

for n = 1:length(freq)
    k = round(freq(n)*N);
    Wn = exp(-j*2*pi/N*k);
    coeff = 2*cos(k*2*pi/N);
    
    if n==1
        Y(n) = signal(n);
    elseif n == 2
        Y(n) = signal(n)-signal(n-1)*Wn+Y(n-1)*coeff;
    elseif n>2
        Y(n) = signal(n)-signal(n-1)*Wn+Y(n-1)*coeff+Y(n-2);
    end

end


