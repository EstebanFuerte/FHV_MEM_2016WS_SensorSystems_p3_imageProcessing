function [fftvalues] = my_dft( timevalues )
% DFT: Digital Fourier Transformation
%
% Author:   Stefan Stark
% Date:     02.10.2016
% Self implemented DFT

N = length( timevalues ) ;            % DFT Length

k = 0:N-1 ;         % Index variables k and n for twiddle factor matrix
n = 0:N-1 ;
kn = n' * k; 

W(length(k),length(n))= zeros;
W(:,1)=1;
W(1,:)=1;

for i=1:length(k)
    for h=1:length(n)
        W(i,h)=(exp(-j*2*pi/N))^(-kn(i,h));
    end
end
fftvalues=timevalues * W;   % DFT - discrete!
end