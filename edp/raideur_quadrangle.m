function [M,aire] = raideur_quadrangle(vertices)
%
% TP-Projet Equations aux Derivees Partielles
% ENSEEIHT, 2013-2014
%
% Calcul de la matrice raideur sur un element quadrangulaire
% 
% Entrees :
%	vertices : matrice 4x2 contenant les coordonnees des sommets
%		   du quadrangle (orientation dans le sens inverse des
%		   aiguilles d'une montre)
%
% Sorties :
%	M : matrice 4x4 dont le coefficient (i,j) correspond a l'integrale
%	    sur le quadrangle du produit des gradients des fonctions de
%	    base eta_i et eta_j
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
%    Constantes
%
J    = zeros(2,2);
J    = [vertices(2,:)-vertices(1,:); vertices(4,:)-vertices(1,:)]';
T    = inv(J'*J);
aire = det(J);
%
% Calcul explicite  de la matrice  
%
a = T(1,1);
b = T(1,2);
c = T(2,2);
M = zeros(4,4);
%
% La formule pour U et M s'obtient par un calcul analytique 
% 
U = [ (a+c)  -2*a+c    -3*b-a-c   a-2*c;
      0       (a+c)    a-2*c      3*b-a-c;
      0        0       (a+c)      -2*a+c;
      0        0       0           (a+c)];
      
D = diag([3*b;-3*b;3*b;-3*b]);
M = aire*(U'+D+U)/6.;

% Autre methode de calcul de M, plus proche des expressions analytiques 
% (peut etre utilisee pour verifier le resultat precedent)
%
%D_Phi = [vertices(2,:)-vertices(1,:); vertices(4,:)-vertices(1,:)]';
%B = inv(D_Phi'*D_Phi);
%C1 = [2,-2;-2,2]*B(1,1)+[3,0;0,-3]*B(1,2)+[2,1;1,2]*B(2,2);
%C2 = [-1,1;1,-1]*B(1,1)+[-3,0;0,3]*B(1,2)+[-1,-2;-2,-1]*B(2,2);
%M_check = det(D_Phi) * [C1 C2; C2 C1] / 6;
%M
%M_check
