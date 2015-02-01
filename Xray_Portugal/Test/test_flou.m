imshow(S);
m = select_init_mask(S);
hold on
[ITS,DELT_PHI,seg] = region_seg_stop_test_1(S,m,1000,0.4,true,10E-9)