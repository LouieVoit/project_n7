I = imread('fullBlack.jpg');  %-- load the image
I = imresize(I,.2);  %-- make image smaller 
imshow(I);
size(I)

m = select_control_points(I);

G = gravity_map_from_mask(m, 1);

[x,y,z] = size(I);

[X,Y] = meshgrid(1:y,1:x);

size(X);
size(Y);
size(G);

mesh(X,Y,G);