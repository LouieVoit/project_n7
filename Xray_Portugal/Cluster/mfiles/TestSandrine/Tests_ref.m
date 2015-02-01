%%%%%%%%%%%
%% Lancement de tests
%%%%%%%%%%%%%%
clc
clear all
close all

% mode == 1 : affichage sur même figure
% mode == 2 : génération de 7 figures
mode = 2;

imageName = 'rx4.jpg';
imageNameShort = 'rx4';


I1=imread(imageName);
I=double(I1(:,:,1));
disp('Taille de l image')
[n1,m1,p]=size(I);

seuil=[];


if(mode == 1)
  figure
  hold on
  colormap('gray');
  subplot(3,3,1)
   d = edge(I,'sobel',seuil);  
   %figure
   imshow(d)
  %imagesc(I1)
  title(['Original data ' ]);
else
  figure
  colormap('gray');
  %imagesc(I1)
   d = edge(I,'sobel',seuil);  
        figure
        imshow(d)
  title(['Original data ' ]);
  saveName = [ imageNameShort, '_Original'];
  saveas(gcf, saveName, 'jpg');
end

% Nombre de classes 
k=3;

for k=4


% Choix de la méthode :
% 1 = Global Kmeans avec distance L1 niveau de gris
% 2 = Global Kmeans avec distance L2 niveau de gris
% 3 = Global Kmeans avec distance géométrique L1 en niveau de gris
% 4 = Global Kmeans avec distance géométrique L2 en niveau de gris
% 5 = Kmeans classique avec distance euclidienne distance L1
% 6 = Kmeans classique avec distance euclidienne distance L2

for choix=1:6

  if choix<=2

    % Pour une segmentation en niveau de gris
    disp('Premier jeu de données')
    points2=zeros(n1*m1,1);
    points=I(:);

    %%Taille du jeu de données
    disp('nbre de points')
    [n,m]=size(points);

    %% Méthode 1 ou 2 : Global Kmeans avec distance niveau de gris L1 ou L2
    disp('Test du Global Kmeans L1 ou L2')
    [Er,M,nb] = GlobalKmeans(points,[],k,0,0,0,choix);
    %dyn=1 fast global kmeans ,
    %dyn=4 global kmeans 
    %dyn=0 for random initialisation

    [distance]=sqdist(M',points',choix);
    [~,IDX]=min(distance',[],2);

    if mode==1
     if choix==1
        subplot(3,3,2)
      else
        subplot(3,3,3)
      end
      I4=reshape(IDX,n1,m1);
      I4=ipermute(I4,[1,2,3]);
       d = edge(I4,'sobel',seuil);  
        
        imshow(d)
      %I5=uint8(I4);
      
      %imagesc(I5)
      %rotate3d on
      if choix==1
        title('Global Kmeans i1')
      else
        title('Global Kmeans i2')
      end
    else
      figure
      colormap('gray');
      I4=reshape(IDX,n1,m1);
      I4=ipermute(I4,[1,2,3]);
        d = edge(I4,'sobel',seuil);  
        
        imshow(d)
      %I5=uint8(I4);
      %imagesc(I5)
      %rotate3d on
      if choix==1
        title('Global Kmeans i1')
        saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_i1'];
      else
        title('Global Kmeans i2')
        saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_i2'];
      end
      saveas(gcf, saveName, 'jpg');
    end

    %DetectContour

  elseif choix<=4 

    %Pour une segmentation géométrique + niveau de gris
    disp('Deuxième jeu de données')
    Data=zeros(n1*m1,3);
    for i=1:n1
      for j=1:m1
        Data((i-1)*m1+j,:)=[i/n1,j/m1,I(i,j)/256];
      end
    end
    points=Data;

    %%Taille du jeu de données
    disp('nbre de points')
    [n,m]=size(points);

    %% Méthode 3 ou 4 : Global Kmeans avec distance géométrique
    disp('Test du Global Kmeans Géométrique L')
    [Er,M,nb] = GlobalKmeans(points,[],k,0,0,0,choix-2);
    %dyn=1 fast global kmeans ,
    %dyn=4 global kmeans 
    %dyn=0 for random initialisation

    [distance]=sqdist(M',points',choix-2);
    [~,IDX]=min(distance',[],2);

    if mode == 1
      if choix==3
        subplot(3,3,5)
      else
        subplot(3,3,6)
      end

      I4=reshape(IDX,m1,n1);
      I4=ipermute(I4,[2,1,3]);
       d = edge(I4,'sobel',seuil);  
        
        imshow(d)
      %I5=uint8(I4);
      %imagesc(I5)
      if choix==3
        title('Global Kmeans g2i1')
      else
        title('Global Kmeans g2i2')
      end
    else
      figure
      colormap('gray');
      I4=reshape(IDX,m1,n1);
      I4=ipermute(I4,[2,1,3]);
       d = edge(I4,'sobel',seuil);  
        
        imshow(d)
      %I5=uint8(I4);
      %imagesc(I5)
      if choix==3
        title('Global Kmeans g2i1')
        saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_g2i1'];
      else
        title('Global Kmeans g2i2')
        saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_g2i2'];
      end
      saveas(gcf, saveName, 'jpg');
    end
    %DetectContour

  else
    % Pour une segmentation en niveau de gris
    disp('Premier jeu de données')
    points2=zeros(n1*m1,1);
    points=I(:);

    %%Taille du jeu de données
    disp('nbre de points')
    [n,m]=size(points);


    %% Méthode 5 ou 6 : Algorithme Kmeans sur image
    disp('Test du Kmeans')
    if choix==5
      disp('Distance L1')
      [IDX,C]=kmeans(points,k,'start','uniform','distance','cityblock');
    else 
      disp('Distance L2')
      [IDX,C]=kmeans(points,k,'start','uniform');
    end

    if mode == 1
      if choix==5
        subplot(3,3,8)
      else 
        subplot(3,3,9)
      end

      I4=reshape(IDX,n1,m1);
      I4=ipermute(I4,[1,2,3]);
       d = edge(I4,'sobel',seuil);  
        
        imshow(d)
      %I5=uint8(I4);
      %imagesc(I5)
      %rotate3d on
      if(choix == 5)
        title('Kmeans i1');
      else
        title('Kmeans i2');
      end
    else
      figure
      colormap('gray');
      I4=reshape(IDX,n1,m1);
      I4=ipermute(I4,[1,2,3]);
       d = edge(I4,'sobel',seuil);  
       
        imshow(d)
      %I5=uint8(I4);
      %imagesc(I5)
      %rotate3d on
      if(choix == 5)
        title('Kmeans i1');
        saveName = [ imageNameShort, '_', num2str(k), '_Kmeans_i1'];
      else
        title('Kmeans i2');
        saveName = [ imageNameShort, '_', num2str(k), '_Kmeans_i2'];
      end
      saveas(gcf, saveName, 'jpg');
    end

  end %if

end % for choix=1:6

%close all

end % for k=3:8 
