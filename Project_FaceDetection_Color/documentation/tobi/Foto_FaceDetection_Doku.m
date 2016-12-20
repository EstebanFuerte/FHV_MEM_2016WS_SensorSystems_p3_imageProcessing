% University of Applied Sciences Vorarlberg
% Master of Mechatronics
% ------------------------------------------------------------------------
% Course:       Sensor Systems
% ------------------------------------------------------------------------
% Author:       Tobias Burtscher and Stefan Stark
% Date:         18.12.2016
% Description:  Face Detection in images.

%%
clear all, close all, clc;    % Clean up
I = imread('group1.jpg');     % Load image

YCBCR = rgb2ycbcr(I);        % Transfer image into YCbCr color space
y = YCBCR(:,:,1);            % Extract y,cb and cr information
cb = YCBCR(:,:,2);
cr = YCBCR(:,:,3);

% Threshold cb and cr values to get a binary image
thresh_cb = cb > 76 & cb < 125;
thresh_cr = cr > 140 & cr < 165;
binary_pic = thresh_cb&thresh_cr;

% Label all the connected components (blobs) in the image
bw=bwlabel(binary_pic,8);

% Image blob analysis - we get a set of properties for each labeled region
area=regionprops(bw,'Area');
eulernumber=regionprops(bw,'EulerNumber');
eccentricity=regionprops(bw,'Eccentricity');
centroid=regionprops(bw,'Centroid');
boundingbox=regionprops(bw,'BoundingBox');

subplot(2,2,3); imshow(I);  % Show image
title('detected faces');    % Create title of figure
nr_faces = 0;               % Initialize variable for counting faces
hold on                     % Hold image to add rectangle

% Loop every blob
for i=1:length(area)
    
    % Decide if skin area is a face
    if eccentricity(i).Eccentricity<0.91 && area(i).Area>2000 ...
		&& eulernumber(i).EulerNumber<=0
        
        bb=boundingbox(i).BoundingBox;  % save bounding box values in bb
        width = bb(3);                  % width of bounding box
        height = bb(4);                 % height of bounding box
        ratio = width/height;           % height to width ratio of box        
   
        % Discard blob if height to width ratio is greater than 1.2
        if ratio<1.2
            
        bc=centroid(i).Centroid;	% Coordinates for rectangle center
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)  % Draw rectangle
        plot(bc(1),bc(2),'-m+')   	% Draw rectangle center
        nr_faces = nr_faces+1;		% Increment counter
        end
    end
end

fprintf('\n  Detected number of faces: %i\n',nr_faces);	% print number of faces

subplot(2,2,1);
imshow(I)                          % Show the original image
title('original')                  % Create title of figure

subplot(2,2,2);
imshow(binary_pic)                 % Show the thresholded binary image
title('binary with thresholding')  % Create title of figure

