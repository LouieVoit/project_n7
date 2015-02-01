I = imread('fullBlack.jpg');  %-- load the image
I = imresize(I,.1);  %-- make image smaller 
imshow(I);
size(I)

m = select_init_mask(I);

G = gravity_map_from_mask_2(m, 1);

[x,y,z] = size(I)

[X,Y] = meshgrid(1:y,1:x);

mesh(X,Y,G);