function [l] = map(i,j,n)
%
% 
% Variables d'entree:
% =================
% i,j: indices discrets du point (1<= i <= n) et (1<= j <= n)
% n: designe le nombre total de points sur une ligne donnee incluant
%   les points fantomes
%   les points frontieres
%   les points interieurs
%   
% Variable de sortie:
% ===================
% l : indice de rangement du couple (i,j) au sein de l'ensemble discret {1,...,n^2}
%
%

% Ordonnancement lexicographique (premiere dimension en premier puis seconde dimension)
l = i+(j-1)*n;
