disp('Test tp1');
tp1([],[],100);
pause;
close all;
disp('Test interpolation fonction 1/(1+25x^2)');
disp('Pas 2/5');
x=-1:(2/5):1;
fx=f(x);
tp1(x,fx,100);
pause;  
disp('Pas 2/10');
figure;
hold on;
x=-1:(2/10):1;
fx=f(x);
tp1(x,fx,100);
hold off; 
pause;
close all;
