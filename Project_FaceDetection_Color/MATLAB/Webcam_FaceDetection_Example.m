% Source: https://www.youtube.com/watch?v=41EyAd8NCjA

clear,clc;

%Create a detector object
faceDetector = vision.CascadeObjectDetector;

%Read input image from usb webcam
obj = imaq.VideoDevice('winvideo', 1,'YUY2_1280x720');
set(obj,'ReturnedColorSpace','rgb');
%preview(obj)
figure('menubar','none','tag','webcam');
while(true) 
    frame=step(obj); %Detect faces 
    bboxes = step(faceDetector,frame); %Annotate detected faces. 
    IFaces = insertObjectAnnotation(frame,'rectangle',bboxes,'ME'); 
    imshow(IFaces,'border','tight') 
    f=findobj('tag','webcam'); 
    if(isempty(f)) 
        close(gcf) 
        break 
    end
    pause(0.05)
end

%closeprview(obj)
release(obj)