z=[1,5,1;0.5,2,0.5;1,3,1;1,4,3;5,8,1];
x=0:4;
y=0:2;
disp('Test tp2 : surface initiale');
casteljau_3d(x,y,z,0);
pause;
close;
disp('Test tp2 : 1 iteration');
casteljau_3d(x,y,z,1);
pause;
close;
disp('Test tp2 : 2 itérations');
casteljau_3d(x,y,z,2);
pause;
close;
disp('Test tp2 : 8 itérations');
casteljau_3d(x,y,z,8);
pause;
close;