% Demo of "Region Based Active Contours"
%
% Example:
% seg_demo
%
% Coded by: Shawn Lankton (www.shawnlankton.com)

close all;
clear;

I = imread('rx2.jpg');  %-- load the image
%I = imresize(I);  %-- make image smaller 
figure(2)
imshow(I)
map = esp_map(I,5,5);
S = var_map(map,10,10);
S = (map/(max(max(map))));
S = uint8(255*S);
figure(3)
imshow(S)
figure(1)
subplot(2,2,1); imshow(S); title('Input Image');

m = select_init_mask(I);
mg = select_init_mask(I);
G = gravity_map_from_mask_2(mg, 100);

subplot(2,2,1); imshow(I); title('Input Image');
subplot(2,2,2); imshow(m); title('Initialization');
subplot(2,2,3); title('Segmentation');

%-- Segmentation
maxit=3000;
tol=1e-7;
alpha=.2;
[ITS,DELT_PHI,seg] = region_seg_stop_area_weight(S, m, maxit, alpha, true, tol, G);

subplot(2,2,4); imshow(seg); title('Global Region-Based Segmentation');


