% University of Applied Sciences Vorarlberg
% Master of Mechatronics
% ------------------------------------------------------------------------
% Course:       Sensor Systems
% ------------------------------------------------------------------------
% Author:       Tobias Burtscher and Stefan Stark
% Date:         18.12.2016
% Description:  Face Detection in a webcam video stream.     

%%
clear all, close all, clc;             % clean up

% Get the webcam-video input in the desired resolution
vid = videoinput('winvideo', 1,'YUY2_320x240');

set(vid,'FramesPerTrigger',Inf);       % Keep acquiring frames until end condition
set(vid,'ReturnedColorSpace','YCbCr'); % Specify returned color space
vid.FrameGrabInterval = 5;             % Acquire only every 5th frame from video
									   % stream

start(vid);                            % Start video stream

while(vid.FramesAcquired<=100)         % Stop loop after 100 acquired frames
    tic
    data=getsnapshot(vid);             % Take a snapshot of video stream
    toc
    
    % Extract y,cb and cr information
    y = data(:,:,1);
    cb = data(:,:,2);
    cr = data(:,:,3);
    
    % Threshold cb and cr values to get a binary image
    thresh_cb = cb > 76 & cb < 125;
    thresh_cr = cr > 135 & cr < 165;
    binary_pic = thresh_cb&thresh_cr;
    
    % Label all the connected components (blobs) in the image
    bw=bwlabel(binary_pic,8);
    
    % Image blob analysis - we get a set of properties for each labeled region
    area=regionprops(bw,'Area');
    eulernumber=regionprops(bw,'EulerNumber');
    eccentricity=regionprops(bw,'Eccentricity');
    centroid=regionprops(bw,'Centroid');
    boundingbox=regionprops(bw,'BoundingBox');
    
    combine_layers=cat(3,y,cb,cr);          % Combine the y,cb and cr layer
    color_image=ycbcr2rgb(combine_layers);  % Convert snapshot to rgb space
    imshow(color_image);                    % Show snapshot
    hold on                                 % Hold image to add rectangle
   
    % Loop every blob
    for i=1:length(area)
        
        % Decide if skin area is a face
        if eccentricity(i).Eccentricity<0.91 && eulernumber(i).EulerNumber<=0 ...
			&& area(i).Area>2000
            
            bb=boundingbox(i).BoundingBox;  % Save bounding box values in bb
            width = bb(3);                  % Width of bounding box
            height = bb(4);                 % Height of bounding box
            ratio = width/height;           % Height to width ratio of box
            
            % Discard blob if height to width ratio is greater than 1.2
            if ratio<1.2 
                
                % Draw rectangle around face
                rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
            end          
        end
    end
    hold off       
end

stop(vid);    % Stop video stream after end codition