close all;

I = imread('rx2.jpg');  %-- load the image
I = imresize(I,.5);  %-- make image smaller 
subplot(2,2,1); imshow(I); title('Input Image');

%-- Choose the mask initialisation : rectangular or ellipse
%-- Create initial mask (ellipse selection)
[xa,ya]=ginput(2);
[xb,yb]=ginput(2);
Nb = 10000;
C = 'b';
me=ellipse(xa,ya,xb,yb,C,Nb,I);
[xa,ya]=ginput(2);
[xb,yb]=ginput(2);
Nb = 1000;
C = 'm';
mi=ellipse(xa,ya,xb,yb,C,Nb,I);
mi=abs(mi-1); %Complementaire
id=(find(mi==1&me==1));
m=zeros(size(I,1),size(I,2));
m(id)=1;

% %-- Create initial mask (rectangular selection)
% m = select_init_mask(I);

subplot(2,2,2); imshow(m); title('Initialization');
subplot(2,2,3); title('Segmentation');

%-- Segmentation parameter
max_its=4000;
rad=floor(size(I,2)/15);
alpha=0.8;
method=1;
display=true;

%-- Local circle for the segmentation
subplot(2,2,1);
theta = 0:0.001:2*pi;
x0 = size(I,2)-rad-1;
y0 = rad+1;
hold on;
plot(rad*cos(theta)+x0,rad*sin(theta)+y0,'r-');

%-- Segmentation
subplot(2,2,3);
seg = localized_seg(I,m,max_its,rad,alpha,method,display);

%-- Plot
figure(1);
subplot(2,2,4); imshow(seg); title('Global Region-Based Segmentation');




