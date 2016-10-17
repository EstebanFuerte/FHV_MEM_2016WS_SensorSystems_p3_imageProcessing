% FHV - Master in Meachatronics - Sem 3 - Sensor System - Image Processing
%
% Exersice: Spectrum of distorted Coins - Get rid of the sinusoidal
% distrortion - slide 17
%
% Author:   Stefan Stark
% Date:     13.10.2016

clear all, close all, clc;

%% ToDo / Steps
% 1. create distortion (to remove it afterwards)
% 2. calculate & show spectrum
% 3. create & show notch filter
% 4. Apply filter
% 5. inverse DFT & show image

%% 1. create distortion (to remove it afterwards)
I = imread('coins.png');
figure, imshow(I,[]);
[M N] = size(I);        % M=downwards

% Disturtion should be sinusoidle with 
% Amplitude=0,25  offset=0,75 frequency=16
f = 16;
for row=1:M
    sinus = 0.25*sin(row/M*2*pi*f)+0.75;
    I(row,:)=I(row,:)*sinus;
end
figure, imshow(I,[]); title('line disturtion');

%% 2. calculate & show spectrum
F = fftshift(fft2(I));      % fftshift that the F(0,0) is in the middle
figure; imshow(log10(abs(F)+10),[],'Colormap',jet); colorbar;

pos = zeros(size(F));
pos(M/2+f,N/2)=1;
pos(M/2-f,N/2)=1;
figure; imshow(pos)

%% 3. create & show notch filter
gauss = fspecial('Gaussian',30,6);
figure; surf(gauss);
G = conv2(pos, gauss,'same');       % same to get the same size again
                                    % because by convolution the array
                                    % increases
figure; imshow(G,[]);
G = 1-mat2gray(G);                  % taking the inverse
figure; imshow(G,[]);               % white = 1, black = 0

%% 4. Apply filter
figure;
imshow(log10(abs(F.*G)+10),[],'Colormap',jet); colorbar;

%% 5. inverse DFT & show image
R = ifft2(fftshift(F.*G));
R = abs(R);
figure
subplot(2,1,1); imshow(I);
subplot(2,1,2); imshow(R,[]);