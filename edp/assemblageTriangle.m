function [ A,b] = assemblageTriangle( coordinates,elements3, dirichlet, f )
%ASSEMBLAGE Calcul la matrice A et le vecteur b du systeme Ax=b
% f est definie sur RxR
% coordinates et elements3 sont des matrices a 2 et 3 colonnes
% (contrairement à l'exemple donné dans l'archive)
% dirichlet est une liste contenant les indices des sommets du bord

    %%
    %Initialisation des parametres
    % Utilisation des matrices creuses pour A et d'un vecteur creux pour b
    % en vu des caractéristiques du système
    [nbTriangle,~]=size(elements3);
    [n,~]=size(coordinates);
    A=zeros(n,n);
    b=sparse(n,1);
    
    %%
    %Calcul de A et b en parcourant chaque triangle, on ne calcul que la
    %partie supérieure et diagonale de A puisque A est symétrique
    for i=1:nbTriangle
        triangle = elements3(i,:);
        i1=triangle(1);
        i2=triangle(2);
        i3=triangle(3);
        [aire,barycentre] = triangleValeur(triangle,coordinates);
        [gradEta1,alpha] = eta(i1,triangle,coordinates);
        gradEta2 = eta(i2,triangle,coordinates);
        gradEta3 = eta(i3,triangle,coordinates);
        
        %%
        %Calcul de A
        A(i1,i2) = A(i1,i2) + aire*dot(gradEta1 , gradEta2);
        A(i2,i3) = A(i2,i3) + aire*dot(gradEta2 , gradEta3);
        A(i1,i3) = A(i1,i3) + aire*dot(gradEta1 , gradEta3);

        A(i1,i1) = A(i1,i1) + aire*dot(gradEta1 , gradEta1);
        A(i2,i2) = A(i2,i2) + aire*dot(gradEta2 , gradEta2);
        A(i3,i3) = A(i3,i3) + aire*dot(gradEta3 , gradEta3);

        A(i2, i1) =  A(i1, i2);
        A(i3, i2) =  A(i2, i3);
        A(i3, i1) =  A(i1, i3);
        
        %%
        %Calcul de b
        b(i1)=b(i1)+alpha*feval(f,barycentre)/6;
        b(i2)=b(i2)+alpha*feval(f,barycentre)/6;
        b(i3)=b(i3)+alpha*feval(f,barycentre)/6;
    end
    %%
    %Conditions de Dirichlet
    for i=1:length(dirichlet)
        il=dirichlet(i);
        A(il,:)=zeros(1,n);
        A(il,il)=1;
        b(il)=0;
    end    
    
end

