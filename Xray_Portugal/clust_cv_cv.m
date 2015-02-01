I = imread(filename);
I = imresize(I,0.6);
m = im2mask(I,1);
%m = mask_smoothing(m,1/2);
figure(1);
imshow(I);
% mi = select_init_mask(I);
% figure(5)
% imshow(m);
% pause()
% alpha = 1;
% tol = 10e-9;
% figure(2);
%[ITS,DELT_PHI,m2] = region_seg_stop_test_1(m,mi,1000,alpha,true,tol);
mn = select_init_mask(I);
alpha = 0.4;
figure(4)
I = noircir(mn,I,1/1.1,60,160);
imshow(I);
% [ITS,DELT_PHI,m3] = region_seg_stop_test_1(I,m2,2000,alpha,true,tol);
% figure(3);
% imshow(m3);

