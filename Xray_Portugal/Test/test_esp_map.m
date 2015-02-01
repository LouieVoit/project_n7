Itmp = imread('rx1.bmp');
imshow(Itmp)
region = select_init_mask(Itmp);
size(region)
x = [];
y = [];
for i = 1:size(region,1)
    for j = 1:size(region,2)
        if region(i,j) == 1
            x = [x i];
            y = [y j];
        end
    end
    i+j
end
I = Itmp(x(1):x(length(x)),y(1):y(length(y)));
size(I)
 me = I(:,:,1);
 l1 = 15;
 l2 = 15;
 map = esp_map(me,l1,l2);
 max_var = max(max(map));
 id = find(map < max_var/1000000000);
 map(id) = 0;
 max_var = max(max(map));
 size(map)
 im_map = map./max_var;
 s = 0.05;
 % id1 = find(im_map < s);
 % id2 = find(im_map >= s);
 % im_map(id1) = 1;
 % im_map(id2) = 0;
 imshow(im_map);