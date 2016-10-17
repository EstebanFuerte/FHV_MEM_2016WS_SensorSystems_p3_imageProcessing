% Digital image processing - example
% Color - Segmentation of yellow tennis balls - Euclidean Distance
% lecturer slide: 15

%%
clear all, close all, clc;

%%
I = imread('pictures/tennis.png');

%%
R = double(I(:,:,1));
G = double(I(:,:,2));
B = double(I(:,:,3));

%%
%imshow(I)
%x = impixel
x = [173   206    13;
   214   244    60;
   155   172    28;
   170   198    34;
   190   226    52;
   121   153     6;
   189   223    54;
   190   223    58;
   168   206    15;
   114   143    16;
   175   197    63;
   150   124   106]

%%
a = mean(x)
y = sqrt((R-a(1)).^2+(G-a(2)).^2+(B-a(3)).^2);

%%
Ythr = y<70;
imshow(Ythr);