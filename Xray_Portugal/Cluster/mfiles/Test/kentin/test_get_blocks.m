
I = imread('rx2.jpg');
I = imresize(I,1);
% size(I)
m = im2mask(I,1);
A = rand(10);
%m = A > 1/2
% size(m)
% figure(1)
% imshow(I)

[b,blocks_nb] = get_blocks(m,1);
b;
blocks_nb
%figure(2)
b = imresize(b,1)
imshow(b/blocks_nb);