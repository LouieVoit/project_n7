clear all
close all
clc

I= imread('circuit.tif');
BW1 = edge(I,'prewitt');
figure
imshow(BW1);
BW2=double(BW1);

[ii,jj]=find(BW2==1);

figure
hold on
imagesc(BW2)
axis off
axis([0 size(BW2,2) 0 size(BW2,1)])

pause
plot(jj,ii,'g.','LineWidth',3)
axis off
axis([0 size(BW2,2) 0 size(BW2,1)])
