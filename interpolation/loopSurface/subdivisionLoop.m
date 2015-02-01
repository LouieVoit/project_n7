function [ resNoeuds,resFaces ] = subdivisionLoop( noeuds,faces )
%SUBDIVISIONLOOP Calcul une subdivion d'apres le schema de l'algorithme de
%loop
%INPUTS : 
%noeuds : matrice n*3 contenant les coordonnees dans l'espace des noeuds
%faces : matrice n*3 contenant les indices des noeuds formant les triangles

global iNouveauNoeud
global nNoeudVoisins
nFace = size(faces,1);
nNoeud = size(noeuds,1);
nNoeudVoisins = zeros(nNoeud,nNoeud,3);
resNoeuds = noeuds;
resFaces = [];

iNouveauNoeud=nNoeud+1;

% On ajoute les nouveaux noeuds dans une structure de donnees nNoeudVoisins tq :
% nNoeudVoisins(i1,i2,1) = indice du nouveua noeud inséré entre les noeuds
% i1 et i2
% nNoeudVoisins(i1,i2,1) et nNoeudVoisins(i1,i2,2) = indices des deux noeuds
% voisins

for k=1:nFace
    i1 = faces(k,1); 
    i2 = faces(k,2);
    i3 = faces(k,3);
    
    %On ajoute les 3 noeuds dans le triangle en remplissant nNoeudVoisins
    i12 = ajouterNoeud(i1,i2,i3);
    i13 = ajouterNoeud(i1,i3,i2);
    i23 = ajouterNoeud(i2,i3,i1);
    resFaces = [resFaces;
                i1,i12,i13;
                i12,i2,i23;
                i12,i23,i13;
                i23,i3,i13];
end

% On calcul les coordonnees des nouveaux noeuds et on les mets dans
% resNoeuds(length(noeuds+1):nbNoeudAjoute)
for i1=1:nNoeud
    for i2=(i1+1):nNoeud
        if (nNoeudVoisins(i1,i2,1)~=0) % On est bien sur une arrete
        % 2 cas : noeuds frontieres ou noeud interieur
        i=nNoeudVoisins(i1,i2,1);
        iv1=nNoeudVoisins(i1,i2,2);
        iv2=nNoeudVoisins(i1,i2,3);
        if (iv1~=0 && iv2~=0) %noeud interieur
            resNoeuds(i,:) = (3/8)*(resNoeuds(i1,:)+resNoeuds(i2,:))+(1/8)*(resNoeuds(iv1,:)+resNoeuds(iv2,:));
        else %noeud frontiere
            resNoeuds(i,:)=(1/2)*(resNoeuds(i1,:)+resNoeuds(i2,:));
        end
        end
    end
end

%On modifie les anciens noeuds et on les mets dans
%resNoeuds(1:length(noeuds))

for i=1:nNoeud
    %On calcul les noeuds voisins du noeud i
    noeudVoisins = [];
    for k=1:nNoeud
        if (nNoeudVoisins(min(k,i),max(k,i),1)~=0)
            noeudVoisins=[noeudVoisins,k];
        end
    end
    %On cherche les noeuds voisins j de i tels que
    %nNoeudVoisins(i,j,{2,3})==0. Si il y en a deux, alors ce neoud est sur
    %la frontiere
    noeudVoisinsFrontiere=[];
    for k=1:length(noeudVoisins)
        tmp=noeudVoisins(k);
        if (nNoeudVoisins(min(tmp,i),max(tmp,i),2)==0 || nNoeudVoisins(min(tmp,i),max(tmp,i),3)==0 )
            noeudVoisinsFrontiere=[noeudVoisinsFrontiere, tmp];
        end
    end
    if (length(noeudVoisinsFrontiere)==2) % Noeud frontiere
        resNoeuds(i,:) = (1/8)*(noeuds(noeudVoisinsFrontiere(1),:)+noeuds(noeudVoisinsFrontiere(2),:))+(6/8)*(noeuds(i,:));
    else
       n=length(noeudVoisins);
       beta=(1/n)*(5/8-(3/8+(1/4)*cos(2*pi/n))^2);
       resNoeuds(i,:)=noeuds(i,:)*(1-n*beta)+beta*sum(noeuds(noeudVoisins,:),1);
    end
end 
end

function iNoeud = ajouterNoeud(i1,i2,i3)
%ajouterNoeud : ajoute noeud entre les noeuds i1 et i2
% On impose i1<i2 de sorte à ne pas avoir de doublon pour le couple i1 et
% i2
global iNouveauNoeud
global nNoeudVoisins
    tmp = i2;
    i2 = max(i1,i2);
    i1 = min(tmp,i1);
    if (nNoeudVoisins(i1,i2,1) == 0)
        nNoeudVoisins(i1,i2,1) = iNouveauNoeud;
        iNouveauNoeud = iNouveauNoeud + 1;
        nNoeudVoisins(i1,i2,2) = i3;
    else
        nNoeudVoisins(i1,i2,3)=i3;
    end
    iNoeud = nNoeudVoisins(i1,i2,1);
end

