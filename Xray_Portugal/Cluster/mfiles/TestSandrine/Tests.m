%%%%%%%%%%%
%%
%% Lancement de tests
%%%%%%%%%%%%%%
clc
clear all
close all


I1=imread('rx4.jpg');
I=double(I1(:,:,1));
disp('Taille de l image')
[n1,m1,p]=size(I);


% Choix de la mï¿½thode :
% 1 = Global Kmeans avec distance L1 niveau de gris
% 2 = Global Kmeans avec distance L2 niveau de gris
% 3 = Global Kmeans avec distance gï¿½omï¿½trique L1 en niveau de gris
% 4 = Global Kmeans avec distance gï¿½omï¿½trique L2 en niveau de gris
% 5 = Kmeans classique avec distance euclidienne distance L1
% 6 = Kmeans classique avec distance euclidienne distance L2


% Nombre de classes 
k=8;

for choix = 1:6

if choix<=2


% Pour une segmentation en niveau de gris
disp('Premier jeu de donnï¿½es')
points2=zeros(n1*m1,1);
points=I(:);

%%Taille du jeu de donnï¿½es
disp('nbre de points')
[n,m]=size(points);


%% Mï¿½thode 1 ou 2 : Global Kmeans avec distance niveau de gris L1 ou L2
disp('Test du Global Kmeans L1 ou L2')
[Er,M,nb] = GlobalKmeans(points,[],k,0,0,0,choix);
%dyn=1 fast global kmeans ,
%dyn=4 global kmeans 
% dyn=0 for random initialisation


[distance]=sqdist(M',points',choix);
[~,IDX]=min(distance',[],2);

  figure
 hold on
 colormap('gray');
 subplot(1,2,1)
 imagesc(I1)
 title(['Original data ' ]);
 subplot(1,2,2)
 I4=reshape(IDX,n1,m1);
 I4=ipermute(I4,[1,2,3]);
 I5=uint8(I4);
 imagesc(I5)
 rotate3d on
 title('Global Kmeans distance L')
 
 %DetectContour

elseif choix<=4 

%Pour une segmentation gï¿½omï¿½trique + niveau de gris
 disp('Deuxiï¿½me jeu de donnï¿½es')
Data=zeros(n1*m1,3);
for i=1:n1
  for j=1:m1
      Data((i-1)*m1+j,:)=[i/n1,j/m1,I(i,j)/255];
  end
end
points=Data;


%%Taille du jeu de donnï¿½es
disp('nbre de points')
[n,m]=size(points);



%% Mï¿½thode 3 : Global Kmeans avec distance gï¿½omï¿½trique
disp('Test du Global Kmeans Gï¿½omï¿½trique L')
[Er,M,nb] = GlobalKmeans(points,[],k,0,0,0,choix-2);
%dyn=1 fast global kmeans ,
%dyn=4 global kmeans 
% dyn=0 for random initialisation


[distance]=sqdist(M',points',choix-2);
[~,IDX]=min(distance',[],2);

  figure
 hold on
 colormap('gray');
 subplot(1,2,1)
 imagesc(I1)
 title(['Original data ' ]);
 subplot(1,2,2)
 I4=reshape(IDX,m1,n1);
 I4=ipermute(I4,[2,1,3]);
 I5=uint8(I4);
 imagesc(I5)
 title('Global Kmeans Gï¿½omï¿½trique')
 
 %DetectContour
 
else
    % Pour une segmentation en niveau de gris
disp('Premier jeu de donnï¿½es')
points2=zeros(n1*m1,1);
points=I(:);

%%Taille du jeu de donnï¿½es
disp('nbre de points')
[n,m]=size(points);



%% Mï¿½thode 4 : Algorithme Kmeans sur image
disp('Test du Kmeans')
if choix==5
    disp('Distance L1')
    [IDX,C]=kmeans(points,k,'start','uniform','distance','cityblock');
else 
    disp('Distance L2')
    [IDX,C]=kmeans(points,k,'start','uniform');
    
end

 figure
 hold on
 colormap('gray');
 subplot(1,2,1)
 imagesc(I1)
 title(['Original data ' ]);
 subplot(1,2,2)
 I4=reshape(IDX,n1,m1);
 I4=ipermute(I4,[1,2,3]);
 I5=uint8(I4);
 imagesc(I5)
 rotate3d on
 title('Kmeans');

end
 
 end
 