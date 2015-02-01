function [ A,b ] = assemblageQuadrangle( coordinates,elements4, dirichlet, f )
%ASSEMBLAGE Calcul la matrice A et le vecteur b du systeme Ax=b
% f est definie sur RxR
% coordinates et elements3 sont des matrices a 2 et 4 colonnes
% (contrairement à l'exemple donné dans l'archive)
% dirichlet est une liste contenant les indices des sommets du bord

    %%
    %Initialisation des parametres
    % Utilisation des matrices creuses pour A et d'un vecteur creux pour b
    % en vu des caractéristiques du système
    [nbQuadrangle,~]=size(elements4);
    [n,~]=size(coordinates);
    A=sparse(n,n);
    b=sparse(n,1);
    
    %%
    %Calcul de A et b en parcourant chaque triangle, on ne calcul que la
    %partie supérieure et diagonale de A puisque A est symétrique
    for i=1:nbQuadrangle
        quadrangle = elements4(i,:);
        i1=quadrangle(1);
        i2=quadrangle(2);
        i3=quadrangle(3);
        i4=quadrangle(4);
        [vertices]=[coordinates(i1,1:2);coordinates(i2,1:2);coordinates(i3,1:2);coordinates(i4,1:2)];
        [M,aire]=raideur_quadrangle(vertices);
        
        %%
        %Calcul de A
        A(i1,i2) = A(i1,i2) + M(1,2);
        A(i1,i3) = A(i1,i3) + M(1,3);
        A(i1,i4) = A(i1,i4) + M(1,4);
        A(i2,i3) = A(i2,i3) + M(2,3);
        A(i2,i4) = A(i2,i4) + M(2,4);
        A(i3,i4) = A(i3,i4) + M(3,4);

        A(i1,i1) = A(i1,i1) + M(1,1);
        A(i2,i2) = A(i2,i2) + M(2,2);
        A(i3,i3) = A(i3,i3) + M(3,3);
        A(i4,i4) = A(i4,i4) + M(4,4);

        A(i2, i1) =  A(i1, i2);
        A(i3, i2) =  A(i2, i3);
        A(i3, i1) =  A(i1, i3);
        A(i4, i1) =  A(i1, i4);
        A(i4, i2) =  A(i2, i4);
        A(i4, i3) =  A(i3, i4);
        
        %%
        %Calcul de b
        barycentre = (vertices(1,:) + vertices(2,:) + vertices(3,:) + vertices(4,:))/4 ; 
        b(i1)=b(i1)+aire*feval(f,barycentre)/4;
        b(i2)=b(i2)+aire*feval(f,barycentre)/4;
        b(i3)=b(i3)+aire*feval(f,barycentre)/4;
        b(i4)=b(i4)+aire*feval(f,barycentre)/4;
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

