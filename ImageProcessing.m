%{

Author: James Henry 
Program: ImageProcessing.m
Goal: Create a program that takes care of the processes of image processing
in MATLAB

Requirements: 

1)  Load a grayscale image, apply a threshold, and create a binary image
where pixels above the threshold are set to 1 (white) and others to 
0 (black).

2) Image Masking: Use logical indexing to apply a mask to an image 
(e.g., replace all pixels outside a specific region of interest with black)
   
3) Edge Detection: Implement a simple edge detection algorithm 
(e.g., Sobel operator) and use logical operations to highlight 
edges in an image.

4) Morphological Operations: Apply morphological operations such as 
dilation and erosion using logical matrices to modify the binary image.

%}

%% Load Image & Convert to Grayscale
imageFile = 'grayscaledog.jpg';
grayscaleImage = imread(imageFile);

if size(grayscaleImage, 3) == 3
    grayscaleImage = rgb2gray(grayscaleImage);
end

%% Step 1: Thresholding to Create Binary Image
% Increasing the threshold darkens the binary image; decreasing it brightens it 
thresholdValue = 165; 

binaryImage = grayscaleImage > thresholdValue;  

% shows the image after applying the threshold
figure; imshow(binaryImage); title('Binary Image After Thresholding');

%% Step 2: Image Masking (User-Defined ROI)
figure; imshow(grayscaleImage); % displays the image in grayscale again
title('Draw a polygon around the object, double-click to finalize');
roi = roipoly;  % Lets the user mask out an area of interest 

% Apply a user-defined mask, setting regions outside the ROI to black
maskedImage = grayscaleImage;
maskedImage(~roi) = 0; 

% displays the masked image after being masked with roi 
figure; imshow(maskedImage); title('Masked Image with ROI');

%% Step 3: Apply Sobel Edge Detection (Optimized)
% Sobel operator for optimized edge detection.
edgeImage = sobelEdgeDetection(grayscaleImage);

% displays the edge image 
figure; imshow(edgeImage); title('Sobel Edge Detection');

%% Step 4: Morphological Operations
% strel is used for erosion and dilation in MATLAB 
dilatedImage = imdilate(binaryImage, strel('disk', 2)); % Dilation
erodedImage = imerode(binaryImage, strel('disk', 2));   % Erosion

% This is where I take the dilated and eroded image, and display them
figure;
subplot(1,2,1), imshow(dilatedImage), title('Dilated Image');
subplot(1,2,2), imshow(erodedImage), title('Eroded Image');

%% I used this to save my results 
imwrite(maskedImage, 'masked_dog_polygon.jpg');
imwrite(edgeImage, 'sobel_edges.jpg');
imwrite(dilatedImage, 'dilated_image.jpg');
imwrite(erodedImage, 'eroded_image.jpg');

%% Optimized Sobel Edge Detection Function (implementation)
function edgeImage = sobelEdgeDetection(image)
    % Convert image to double for precision
    image = double(image);
    
    % Sobel Kernels
    GxKernel = [-1 0 1; -2 0 2; -1 0 1];  
    GyKernel = [1 2 1; 0 0 0; -1 -2 -1];  

    % Convolution for edge detection (Sobel filtering)
    Gx = conv2(image, GxKernel, 'same');  
    Gy = conv2(image, GyKernel, 'same');

    % Gradient magnitude sqrt(x^2 + y^2) 
    edgeImage = sqrt(Gx.^2 + Gy.^2);
    
    % Threshold to max pixel values from 0 to 255 
    edgeImage(edgeImage > 255) = 255;
    
    % Convert results to 8-bit unsigned integer format for readability 
    edgeImage = uint8(edgeImage);
end
