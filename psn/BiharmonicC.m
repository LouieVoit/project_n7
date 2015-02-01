 function [A,b,xc,x,M] = BiharmonicC(n)
%
% Discretisation de type differences finies d'ordre deux de l'oppose de l'operateur 
% Biharmonique avec le systeme couple 
% sur le carre [-1,1]x[-1,1] avec comme conventions: 
% 
% Variable d'entree:
% =================
% n: designe le nombre total de points sur une ligne horizontale donnee incluant
%   les points frontieres [2] 
%   les points interieurs [n-2]
%   
% Variables de sortie:
% ===================
% A: matrice issue de la discretisation sur l'ensemble du domaine (interieur, frontiere et fantome)
% b: second membre du systeme lineaire defini sur l'ensemble du domaine (interieur, frontiere et fantome)
% xc: Solution du systeme lineaire couple
% x: solution qui approche la vraie solution u du systeme non couple de
% départ
% 
% Fonctions appelees: [indice] = map(i,j,n);
%
h  = 2./(n-1);
%

%
% Definition des frontieres
%
% Top
Ft = [map(1,1,n)  :n:map(1,n,n)]';
% Bottom
Fb = [map(n,1,n):n:map(n,n,n)]';
% Left
Fl = [map(1,1,n)  :  map(n,1,n)]';
% Right
Fr = [map(1,n,n):  map(n,n,n)]';
F  = [Fl;Fr;Ft;Fb];

F  = unique(F);
%
% Definition des points interieurs dans l'ordre lexicographique
%
I  = [];
for j=2:n-1
    for i=2:n-1
        I = [I;map(i,j,n)];
    end
end
% Ensemble de points utiles
IF=[I;F];
%
% Dimensionnement de A et de b et de la solution x
%
d = size(IF,1);%=n^2
A = speye(2*d,2*d);
b = zeros(2*d,1);
xc = zeros(2*d,1);
%%
% Definition de A et de b aux points interieurs
%
s  = n ;
for loop = 1:size(I,1)
    i = I(loop,1);
    A(i,[i-s i-1 i i+1 i+s]) = (1/h^2)*[1 1 -4 1 1];
end
A((d+1):(2*d),(d+1):(2*d))=A(1:d,1:d);
A((d+1:2*d),1:d)=-eye(d);
% b 
for loop=1:size(I,1)
    ind=I(loop,1);
    [i,j]=unmap(ind,n);
    x=-1+h*(j-1);
    y=1-h*(i-1);
    b(ind)=f(x,y);
end
%%
% Definition de A et de b aux points frontieres
%
for loop=1:size(F,1)
    i=F(loop,1);
    A(d+i,i)=0;
end
%b
for loop=1:size(F,1)
    ind=F(loop,1);
    [i,j]=unmap(ind,n);
    x=-1+h*(j-1);
    y=1-h*(i-1);
    b(ind)=f2(x,y);
    b(d+ind)=f1(x,y);
end
%%
% Solution du systeme en ayant recours au \ de Matlab 
%
 xc= A\b;
%
% Calcul de l'erreur inverse en norme 1
%
 norm(b-A*xc,1)/(norm(b,1)+norm(A,1)*norm(xc,1))
 x=xc(d+1:2*d);   
%%
%Construction de M=(f_sol(xi,yj))
M=zeros(n,n);
M(:,1)=x(Fl);
M(:,n)=x(Fr);
M(n,:)=x(Fb);
M(1,:)=x(Ft);
for i=1:size(I,1)
    ind=I(i,1);
    [i,j]=unmap(ind,n);
    M(i,j)=x(ind);
end

end
 %%
 %Definition fonctions du probleme
 function res = f(x,y)
    %res=8;
    res=72*(x^2+y^2);
 end
 function res = f1(x,y)
    res=x^2*y^4+y^2*x^4;
    %res=x^2*y^2;
 end
 function res = f2(x,y)
    %res=2*(x^2+y^2);
    res=2*(x^4+12*x^2*y^2+y^4);
 end