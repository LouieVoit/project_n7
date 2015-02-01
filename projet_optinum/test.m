
function test(X,epsilon,c1,c2,s0,f,grad,hess)

%epsilon=0.01;
iterMax=5000;
%X=[10;10];
%c1=0.1;
%c2=0.8;
%s0=1;
global nfev ngev nhev
nfev=0;
ngev=0; 
nhev=0;

f=@(X)f(X);
grad=@(X)grad(X);
hess=@(X)hess(X);
pas_cons = @(f,grad,hess,x,d,c1,c2) pas_constant(f,grad,hess,x,d,c1,c2);
back = @(f,grad,hess,x,d,c1,c2) backtracking(f,grad,hess,x,d,c1,c2);
biss = @(f,grad,hess,x,d,c1,c2) bissection(f,grad,hess,x,d,c1,c2);
inter = @(f,grad,hess,x,d,c1,c2) interpolation(f,grad,hess,x,d,c1,c2);
appr = @(f,grad,hess,x,d,c1,c2) approche(f,grad,hess,x,d,c1,c2);
B0=[1,0;0,1];

disp('newtonlocal');
min_newton(f, grad, hess, X, epsilon,iterMax);
disp('descente pas constant');
min_grad(f, grad, hess, X, epsilon, pas_cons, c1, c2, iterMax);
disp('descente backtracking');
min_grad(f, grad, hess, X, epsilon, back, c1, c2, iterMax);
disp('descente bissection');
min_grad(f, grad, hess, X, epsilon, biss, c1, c2, iterMax);
disp('descente pas interpolation');
min_grad(f, grad, hess, X, epsilon, inter, s0, c1, iterMax);
disp('descente approche');
min_grad(f, grad, hess, X, epsilon, appr, c1, c2, iterMax);
disp('quasi-newton bfgs pas constant');
bfgs(f, grad, B0, X, epsilon, pas_cons, c1, c2, iterMax,1);
disp('quasi-newton bfgs backtracking');
bfgs(f, grad, B0, X, epsilon, back, c1, c2, iterMax,1);
disp('quasi-newton bfgs bissection');
bfgs(f, grad, B0, X, epsilon, biss, c1, c2, iterMax,1);
disp('quasi-newton bfgs interpolation');
bfgs(f, grad, B0, X, epsilon, inter, s0, c1, iterMax,1);
disp('quasi-newton bfgs approche');
bfgs(f, grad, B0, X, epsilon, appr, c1, c2, iterMax,1);
disp(['nfev : ' num2str(nfev)]);
disp(['ngev : ' num2str(ngev)]);
disp(['nhev : ' num2str(nhev)]);

