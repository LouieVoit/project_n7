% Demo of "Region Based Active Contours"
%
% Example:
% seg_demo
%
% Coded by: Shawn Lankton (www.shawnlankton.com)

close all
clear all

I = imread('rx1.bmp');  %-- load the image
m = zeros(size(I,1),size(I,2));          %-- create initial mask
m(200:300,150:200) = 1;

I = imresize(I,.5);  %-- make image smaller 
m = imresize(m,.5);  %   for fast computation

figure(1);
subplot(2,2,1); imshow(I); title('Input Image');
subplot(2,2,2); imshow(m); title('Initialization');
subplot(2,2,3); title('Segmentation');

maxit = 3000;
seg = region_seg(I, m, maxit, 0.01, true);



figure(1);
subplot(2,2,4); imshow(seg); title('Global Region-Based Segmentation');



