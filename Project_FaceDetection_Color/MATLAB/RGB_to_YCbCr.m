clear,clc;
I=imread('me1.jpg');

YCBCR = rgb2ycbcr(I);
y = YCBCR(:,:,1);
cb = YCBCR(:,:,2);
cr = YCBCR(:,:,3);

thresh_cb = cb > 105 & cb < 120;
thresh_cr = cr > 140 & cr < 165;

face = cat(3,y,thresh_cb,thresh_cr);
original = ycbcr2rgb(face);

subplot(1,4,1);
imshow(y)

subplot(1,4,2);
imshow(thresh_cb)

subplot(1,4,3);
imshow(thresh_cr)

subplot(1,4,4);
imshow(face)

% %% RGB stuff
% R = I(:,:,1);
% G = I(:,:,2);
% B = I(:,:,3);
% 
% image = cat(3,R,G,B);
% 
% subplot(1,5,1);
% imshow(R)
% 
% subplot(1,5,2);
% imshow(G)
% 
% subplot(1,5,3);
% imshow(B)
% 
% subplot(1,5,4);
% imshow(I)
% 
% subplot(1,5,5);
% imshow(image)
