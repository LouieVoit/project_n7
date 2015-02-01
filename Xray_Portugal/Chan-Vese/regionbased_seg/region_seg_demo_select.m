% Demo of "Region Based Active Contours"
%
% Example:
% seg_demo
%
% Coded by: Shawn Lankton (www.shawnlankton.com)

close all;
clear;

I = imread('rx2.jpg');  %-- load the image
I = imresize(I,.5);  %-- make image smaller 
subplot(2,2,1); imshow(I); title('Input Image');

m = select_init_mask(I);

subplot(2,2,1); imshow(I); title('Input Image');
subplot(2,2,2); imshow(m); title('Initialization');
subplot(2,2,3); title('Segmentation');

%-- Segmentation
maxit=3000;
tol=1e-7;
alpha=4;
[ITS,DELT_PHI,seg] = region_seg_stop_test_1(I, m, maxit, alpha, true, tol);

subplot(2,2,4); imshow(seg); title('Global Region-Based Segmentation');


