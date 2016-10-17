% Digital image processing - example
% Spatial Filterning - Example Gradient filtering
% lecturer slide: 25

%%
clear all, close all, clc;

%%
I = imread('coins.png');
I = im2double(I);

F = fspecial('prewitt');
IF1 = imfilter(I,F);
figure; imshow(IF1, []);
IF2 = imfilter(I,F');
figure; imshow(IF2, []);