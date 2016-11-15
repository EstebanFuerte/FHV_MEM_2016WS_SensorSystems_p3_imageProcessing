clear, clc;

x=videoinput('winvideo', 1,'YUY2_640x480');
info = imaqhwinfo(x);
set(x,'ReturnedColorSpace','YCbCr');

preview(x)