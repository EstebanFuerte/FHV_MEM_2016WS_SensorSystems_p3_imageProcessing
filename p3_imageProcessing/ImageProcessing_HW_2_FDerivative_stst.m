% FHV - Master in Meachatronics
% Sensor System - Image Processing
%
% Exersice: First derivative of a Gaussian as filter mask
%           Use the first derivative of a Gaussian as a filter mask for 
%           detecting steps
%
% Author:   Stefan Stark
% Date:     05.10.2016

%%
clear all, close all, clc;

%%
%f = [0 0 1 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0,... 
%    1 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0];
f = [ 6 6 6  5 4 3 2 1 1 1 1 1 1 6 6 6 6];


figure;plot(f,'o');

%%
F = [0 -1 1];
f_1der = imfilter(f,F);
hold on; plot(f_1der,'o');

figure;plot(f,'o');
gauss = fspecial('gaussian',[1 5]); % create gaussian
filtered = imfilter(f,gauss);
hold on; plot(filtered,'o');
f_1der_fil = imfilter(filtered,F);
hold on; plot(f_1der_fil,'o');
legend('original','gaussFiltered','gaussDeriv');

%% Input from lecutrer
filter_len = 21;
sigma = 2;

x = -round(filter_len/2-0.5): round(filter_len/2-0.5);
filter = -x./power(sigma,2).*exp(-power(x,2)./(2*power(sigma,2)));
figure
plot(x,filter)