clear all
close all

Itmp = imread('rx2.jpg');
%Itmp = imresize(Itmp,0.5);
imshow(Itmp)
region = select_init_mask(Itmp);
size(region)
x = [];
y = [];
for i = 1:size(region,1)
    for j = 1:size(region,2)
        if region(i,j) == 1
%             x = [x i];
%             y = [y j];
        end
    end
end
I = Itmp;%(x(1):x(length(x)),y(1):y(length(y)));
'FINIT'
%size(I)
 me = I(:,:,1);
 l1 = 20;
 l2 = 20;
 map = var_map(me,l1,l2);
 max_var = max(max(map));
 id = find(map < max_var/5);
 map(id) = 0;
 max_var = max(max(map));
 size(map)
 im_map = map./max_var;
%  s = 0.05;
%  id1 = find(im_map < s);
%  id2 = find(im_map >= s);
%  im_map(id1) = 1;
%  im_map(id2) = 0;
 imshow(im_map);