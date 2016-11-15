clear,clc;

I = imread('me3.jpg');
[rows columns numberOfColorBands] = size(I);

imshow(I);
title('Original Color Image');

redChannel = I(:, :, 1);
greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);

% Construct the 3D color gamut (3D histogram).
gamut3D = zeros(256,256,256);
for column = 1: columns
	for row = 1 : rows
		rIndex = redChannel(row, column) + 1;
		gIndex = greenChannel(row, column) + 1;
		bIndex = blueChannel(row, column) + 1;
		gamut3D(rIndex, gIndex, bIndex) = gamut3D(rIndex, gIndex, bIndex) + 1;
	end
end

% Get a list of non-zero colors so we can put it into scatter3()
% so that we can visualize the colors that are present.
r = zeros(256, 1);
g = zeros(256, 1);
b = zeros(256, 1);
nonZeroPixel = 1;
for red = 1 : 256
	for green = 1: 256
		for blue = 1: 256
			if (gamut3D(red, green, blue) > 1)
				% Record the RGB position of the color.
				r(nonZeroPixel) = red;
				g(nonZeroPixel) = green;
				b(nonZeroPixel) = blue;
				nonZeroPixel = nonZeroPixel + 1;
			end
		end
	end
end
figure;
scatter3(r, g, b, 3);
xlabel('R');
ylabel('G');
zlabel('B');