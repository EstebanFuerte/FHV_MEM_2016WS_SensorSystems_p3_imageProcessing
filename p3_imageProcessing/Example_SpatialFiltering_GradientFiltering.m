% Digital image processing - example
% Spatial Filterning - Example Unsharpr Masking
% lecturer slide: 16

%%
clear all, close all, clc;

%%
I = imread('coins.png');
mf = fspecial('Gaussian',5,2);
I1 = imfilter(I,mf);

figure
subplot(1,3,1); imshow(I,[]); title('original');
subplot(1,3,2); imshow(I+(I-I1),[]); title('unsharp masking');
subplot(1,3,3); imshow(1.5*(I+(I-I1)),[]); title('highbosst filtering');