 function [A,b,x,M] = Biharmonic(n)
%
% Discretisation de type differences finies d'ordre deux de l'oppose de l'operateur 
% Biharmonique 
% sur le carre [-1,1]x[-1,1] avec comme conventions: 
% 
% Variable d'entree:
% =================
% n: designe le nombre total de points sur une ligne horizontale donnee incluant
%   les points fantomes   [2]
%   les points frontieres [2] 
%   les points interieurs [n-4]
%   NB: le recours aux points fantomes n'est pas necessaire pour cet operateur
%     mais sera utile pour l'operateur biharmonique.
%   
% Variables de sortie:
% ===================
% A: matrice issue de la discretisation sur l'ensemble du domaine (interieur, frontiere et fantome)
% b: second membre du systeme lineaire defini sur l'ensemble du domaine (interieur, frontiere et fantome)
% x: Solution du systeme lineaire
% 
% Fonctions appelees: [indice] = map(i,j,n);
%
h  = 2./(n-3);
%
% Definitions des lignes de points fantomes 
%
% Gauche
Gl = [map(1,1,n):  map(n,1,n)]';
% Droite
Gr = [map(1,n,n):  map(n,n,n)]';
% Bas
Gb = [map(n,1,n):n:map(n,n,n)]';
% Haut
Gt = [map(1,1,n):n:map(1,n,n)]';
G  = [Gl;Gr;Gb;Gt];

G  = unique(G);
%
% Definition des frontieres
%
% Top
Ft = [map(2,2,n)  :n:map(2,n-1,n)]';
% Bottom
Fb = [map(n-1,2,n):n:map(n-1,n-1,n)]';
% Left
Fl = [map(2,2,n)  :  map(n-1,2,n)]';
% Right
Fr = [map(2,n-1,n):  map(n-1,n-1,n)]';
F  = [Fl;Fr;Ft;Fb];

F  = unique(F);
%
% Definition des points interieurs dans l'ordre lexicographique
%
I  = [];
for j=3:n-2
    for i=3:n-2
        I = [I;map(i,j,n)];
    end
end
% Ensemble de points utiles
IGF=[I;G;F];
IF=[I;F];
%
% Dimensionnement de A et de b et de la solution x
%
d = size(IGF,1);
A = sparse(d,d);
b = zeros(d,1);
x = zeros(d,1);
%%
% Definition de A et de b aux points interieurs
%
s  = n ;
for loop = 1:size(I,1)
    i = I(loop,1);
    A(i,[i-2*s i-1-s i-s i+1-s i-2 i-1 i  i+1 i+2 i+s-1 i+s i+s+1 i+2*s ]) = (1/h^4)*[1 2 -8 2 1 -8 20 -8 1 2 -8 2 1];
end
% b 
for loop=1:size(I,1)
    ind=I(loop,1);
    [i,j]=unmap(ind,n);
    x=-1+h*(j-2);
    y=1-h*(i-2);
    b(ind)=f(x,y);
end
%%
% Definition de A et de b aux points frontieres
%
A(F,F) = speye(size(F,1),size(F,1));
for loop=1:size(F,1)
    ind=F(loop,1);
    [i,j]=unmap(ind,n);
    x=-1+h*(j-2);
    y=1-h*(i-2);
    b(ind)=f1(x,y);
end
%%
% Definition de A et de b aux points fantomes 
%
A(G,G) = speye(size(G,1),size(G,1));
%Points fantomes gauche
for loop = 3:size(Gl,1)-2
    ind=Gl(loop,1);
    A(ind,[ind ind+s-1 ind+s ind+s+1 ind+2*s])=[1 1 -4 1 1];
    [i,j]=unmap(ind+n,n);
    x=-1+(j-2)*h;
    y=1-(i-2)*h;
    b(ind)=h^2*f2(x,y);
end
%Points fantomes haut
for loop = 3:size(Gt,1)-2
    ind=Gt(loop,1);
    A(ind,[ind-s+1 ind ind+1 ind+2 ind+s+1])=[1 1 -4 1 1];
    [i,j]=unmap(ind+1,n);
    x=-1+(j-2)*h;
    y=1-(i-2)*h;
    b(ind)=h^2*f2(x,y);
end
%Points fantomes bas
for loop = 3:size(Gb,1)-2
    ind=Gb(loop,1);
    A(ind,[ind-s-1 ind-2 ind-1 ind ind+s-1])=[1 1 -4 1 1];
    [i,j]=unmap(ind-1,n);
    x=-1+(j-2)*h;
    y=1-(i-2)*h;
    b(ind)=h^2*f2(x,y);
end
%Points fantomes droite
for loop = 3:size(Gr,1)-2
    ind=Gr(loop,1);
    A(ind,[ind-2*s ind-s-1 ind-s ind-s+1 ind])=[1 1 -4 1 1];
    [i,j]=unmap(ind-n,n);
    x=-1+(j-2)*h;
    y=1-(i-2)*h;
    b(ind)=h^2*f2(x,y);
end
%%
% Solution du systeme en ayant recours au \ de Matlab et au partitionnement des inconnues
%
x= A\b;
% x(F) = b(F);
% x(G) = b(G);
%
% Calcul de l'erreur inverse en norme 1
%
norm(b-A*x,1)/(norm(b,1)+norm(A,1)*norm(x,1))
%%
%Construction de M=(f_sol(xi,yj))
M=zeros(n-2,n-2);
M(:,1)=x(Fl);
M(:,n-2)=x(Fr);
M(n-2,:)=x(Fb);
M(1,:)=x(Ft);
for k=1:size(I,1)
    ind=I(k,1);
    [i,j]=unmap(ind,n);
    M(i-1,j-1)=x(ind);
end
 end
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