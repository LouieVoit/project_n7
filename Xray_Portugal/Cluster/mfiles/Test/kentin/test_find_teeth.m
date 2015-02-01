
I = imread('rx2.jpg');
I = imresize(I,0.8);
size(I)
m = im2mask(I,1);
figure(1)
imshow(m);
m2 = find_teeth_2(m,0.05);
figure(2);
imshow(m2)


