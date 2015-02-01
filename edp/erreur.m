function res = erreur( u,c )
%ERREUR Calcul la norme (L2h) du vecteur d'erreur pour la fonction
%sin(pix)sin(piy)
%INPUTS : u vecteur resultat de l'approximation
%INPUTS : c : vecteur des coordonnées
    
res = norm(u - sin(pi*c(:,1)).*sin(pi*c(:,2)));

end

