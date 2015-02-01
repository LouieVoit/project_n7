 function [A,b,x] = Laplace(n)
%
% Discretisation de type differences finies d'ordre deux de l'oppose de l'operateur 
% Laplacien 
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
Gl = [map(1,1,n):n:map(1,n,n)]';
% Droite
Gr = [map(n,1,n):n:map(n,n,n)]';
% Bas
Gb = [map(1,1,n):  map(n,1,n)]';
% Haut
Gt = [map(1,n,n):  map(n,n,n)]';
G  = [Gl;Gr;Gb;Gt];
%
% unique est utilise ici pour eliminer les coins redondants
%
G  = unique(G);
%
% Definition des frontieres
%
% Gauche
Fl = [map(2,2,n)  :n:map(2,n-1,n)]';
% Droite
Fr = [map(n-1,2,n):n:map(n-1,n-1,n)]';
% Bas
Fb = [map(2,2,n)  :  map(n-1,2,n)]';
% Haut
Ft = [map(2,n-1,n):  map(n-1,n-1,n)]';
F  = [Fl;Fr;Ft;Fb];
%
% unique est utilise ici pour eliminer les coins redondants
%
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
%
% Definition des ensembles d'indice utiles par la suite
%
IG  = [I;G];
IGF = [I;G;F];
FG  = [F;G];
%FG  = unique(FG);
%
% Dimensionnement de A et de b et de la solution x
%
d = size(IGF,1);
A = sparse(d,d);
b = zeros(d,1);
x = zeros(d,1);
%
% Definition de A et de b aux points interieurs
%
s  = n ;
for loop = 1:size(I,1)
    i = I(loop,1);
    A(i,[i-1   i     i+1   i-s i+s])       = (1./(h^2))* [-1 4 -1 -1 -1];
end
% b [a definir ici]
b(I) = rand(size(I,1),1);
%
% Definition de A et de b aux points frontieres
%
A(F,F) = speye(size(F,1),size(F,1));
%
% Conditions de Dirichlet homogenes par exemple ici
%
b(F)   = 0;
%
% Definition de A et de b aux points fantomes [ici la zone de points fantomes n'est pas 
%   utilisee pour cet operateur]
%
A(G,G) = speye(size(G,1),size(G,1));
b(G)   = 0;
%
% Ordonnancement des inconnues comme propose dans l'enonce
%
Ordering = IGF;
Ao       = A(Ordering,Ordering);
bo       = b(Ordering,1);
A_lexi   = A(sort(IGF),sort(IGF));
%
% Complement de Schur [elimination des conditions limites et de la partie associee aux points fantomes qui n'est pas utilisee ici]
%
%
As   = A(I,I)-A(I,FG)*(A(FG,FG)\A(FG,I));
%
% Solution du systeme en ayant recours au \ de Matlab et au partitionnement des inconnues
%
x(I) = As\b(I);
x(F) = b(F);
x(G) = b(G);
%
% Calcul de l'erreur inverse en norme 1
%
norm(b-A*x,1)/(norm(b,1)+norm(A,1)*norm(x,1))
