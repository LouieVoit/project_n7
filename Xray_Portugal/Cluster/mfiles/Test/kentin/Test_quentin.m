close all;
clear all;
%- Mask creation
I = imread('rx3.jpg');
I = imresize(I,0.8);
size(I)
m = im2mask(I,1);
max(max(m));
[ms,nb] = get_blocks(m,0);
nb
figure(2)
imshow(ms/nb);

% %- Chan-Vese Segmentation
% I = imresize(I,.5);  %-- make image smaller 
% m = imresize(m,.5);
% subplot(2,2,1); imshow(I); title('Input Image');
% subplot(2,2,2); imshow(m); title('Initialization');
% subplot(2,2,3); title('Segmentation');
% 
% %-- Segmentation parameter
% max_its=4000;
% tol=0;
% rad=floor(size(I,2)/20);
% alpha=0.2;
% method=1;
% display=true;
% 
% %-- Local circle for the segmentation
% subplot(2,2,1);
% theta = 0:0.001:2*pi;
% x0 = size(I,2)-rad-1;
% y0 = rad+1;
% hold on;
% plot(rad*cos(theta)+x0,rad*sin(theta)+y0,'r-');
% 
% %-- Segmentation
% subplot(2,2,3);
% seg = localized_seg(I,m,max_its,tol,rad,alpha,method,display);
% % seg = region_seg(I,m,max_its,alpha,display);
% 
% 
% %-- Plot
% figure(1);
% subplot(2,2,4); imshow(seg); title('Global Region-Based Segmentation');