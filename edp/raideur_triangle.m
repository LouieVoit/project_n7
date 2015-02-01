function M = raideur_triangle(vertices)
%
% TP-Projet Equations aux Derivees Partielles
% ENSEEIHT, 2013-2014
%
% Calcul de la matrice raideur sur un element triangulaire
% 
% Entrees :
%	vertices : matrice 3x2 contenant les coordonnees des sommets
%		   du triangle (orientation dans le sens inverse des
%		   aiguilles d'une montre)
%
% Sorties :
%	M : matrice 3x3 dont le coefficient (i,j) correspond a l'integrale
%	    sur le triangle du produit des gradients des fonctions de
%	    base eta_i et eta_j
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%
%    Constantes
%
d     = size(vertices,2);
alpha = det([ones(1,d+1);vertices']);
aire  = alpha/2.;
%
%    M : matrice raideur locale
%
M     = zeros(3,3);
ind   = [1 2 3 1 2];
%
% Boucle naive sur les elements (loopi,loopj) de la matrice M et remplissage element par element
%
for loopj=1:3    
    jp  = ind(loopj+1);
    jpp = ind(loopj+2);
    v   = [vertices(jp,2) - vertices(jpp,2); vertices(jp,1) - vertices(jpp,1)];
for loopi=1:3
    ip  = ind(loopi+1);
    ipp = ind(loopi+2);
    u   = [vertices(ip,2) - vertices(ipp,2); vertices(ip,1) - vertices(ipp,1)];
    M(loopi,loopj) = aire * v'*u/(alpha*alpha);
end
end
