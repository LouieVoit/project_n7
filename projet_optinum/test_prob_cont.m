
function test_prob_cont(X,epsilon,f,grad,hess,c,jac_c,lambda,mu,tau)

%epsilon=0.01;
%X=[10;10];
%c1=0.1;
%c2=0.8;
%s0=1;
global nfev ngev nhev nfcev ngcev
nfev=0;
ngev=0; 
nhev=0;
nfcev=0;
ngcev=0;

f=@(X)f(X);
grad=@(X)grad(X);
hess=@(X)hess(X);
c=@(X) c(X);
jac=@(X) jac_c(X);

disp('probleme avec contraintes');
prob_cont(f,grad,hess,c,jac,X,lambda,mu,tau,epsilon);
disp(['nfev : ' num2str(nfev)]);
disp(['ngev : ' num2str(ngev)]);
disp(['nhev : ' num2str(nhev)]);
disp(['nfcev : ' num2str(nfcev)]);
disp(['ngcev : ' num2str(ngcev)]);
