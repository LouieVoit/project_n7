function [coordinates, elements3, elements4, dirichlet, neumann] = maillage_carre(n)
%
% Maillage du carre unite en elements uniquement triangulaires => elements4=[]; 
% Les conditions limites sont de type Dirichlet uniquement     => neumann  =[];
%
h           = 1./(n-1);
npoin       = n*n ; 
nelem       = 2*(n-1)*(n-1) ;
coordinates = zeros(npoin,2) ; 
elements3   = zeros(nelem,3) ;
elements4   = zeros((n-1)*(n-1),4);
neumann     = [];
% Coordonnees et connectivites :
e = 0 ; 
e4=0;
p = 0 ;
x = [0 :h :1] ;
for j = 1 :n
    for i = 1 :n
        p = p + 1 ; 
        coordinates(p,1) = x(i) ; 
        coordinates(p,2) = x(j) ;
        if i ~= n & j ~= n
           p1 = p ; p2 = p1 + 1 ; p3 = p1 + n ; p4 = p2 + n ;
           e = e + 1 ; elements3(e,1) = p1 ; elements3(e,2) = p2 ; elements3(e,3) = p3 ;
           e4=e4+1; elements4(e4,1) = p1 ; elements4(e4,2) = p2 ; elements4(e4,3) = p3 ; elements4(e4,4)=p4;
           e = e + 1 ; elements3(e,1) = p4 ; elements3(e,2) = p3 ; elements3(e,3) = p2 ;
        end
    end
end
% Liste des noeuds de la frontiere :
dirichlet = [1:n] ;                          % bas
dirichlet = [dirichlet,n*(2:n-1)] ;          % droite
dirichlet = [dirichlet,(n^2):-1:(n^2-n+1)] ; % haut
dirichlet = [dirichlet,n*(n-1:-1:2)-n+1] ;   % gauche
