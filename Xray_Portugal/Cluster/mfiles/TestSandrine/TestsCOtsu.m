%%%%%%%%%%%
%% Lancement de tests
%%%%%%%%%%%%%%
clc
clear all
close all

imageName = 'rx4.jpg';
imageNameShort = 'rx4';


I1=imread(imageName);
I=double(I1(:,:,1));
disp('Taille de l image')
[n1,m1,p]=size(I);

filtres = {'sobel',  'canny',  'prewitt',  'roberts',  'log',  'zerocross'};

% contour
seuil=[];
filtre = 'canny';

for fi = 1:2

filtre=filtres{fi};

% % image originale
% colormap('gray');
% d = edge(I,filtre,seuil);
% %d = bwareaopen(d,40);
% imshow(d)
% title(['Original data' ]);
% saveName = [imageNameShort, '_Original_', filtre];
% %saveas(gcf, saveName, 'jpg');
% 
% d2 = double(d);
% %d2 = d2(end:-1:1,:);
% [ii,jj]=find(d2==1);
% 
% iout=I./255;
% BW=d2;
% iout(:,:,1) = iout;                           %# Initialize red color plane
% iout(:,:,2) = iout(:,:,1);                    %# Initialize green color plane
% iout(:,:,3) = iout(:,:,1);                    %# Initialize blue color plane
% %iout(:,:,1) = min(iout(:,:,1) + BW, 1.0);     %# Add edges to red color plane
% figure;
% imshow(iout);
% hold on
% plot(jj,ii,'r.','LineWidth',1)
% %title('Original data');
% 
% saveName = [imageNameShort, '_i+c_Original_', filtre];
% 
% ti = get(gca,'TightInset');
% set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
% 
% set(gca,'units','centimeters')
% pos = get(gca,'Position');
% ti = get(gca,'TightInset');
% 
% set(gcf, 'PaperUnits','centimeters');
% set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
% 
% saveas(gcf, saveName, 'jpg');
% 
% %end %for filtre
% return

% Nombre de classes 
for k=3:8

% Choix de la méthode :
% 1 = Kmeans classique avec distance euclidienne distance L1
% 2 = Kmeans classique avec distance euclidienne distance L2
% 3 = Global Kmeans avec distance L1 niveau de gris
% 4 = Global Kmeans avec distance L2 niveau de gris
% 5 = Global Kmeans avec distance géométrique L1 en niveau de gris
% 6 = Global Kmeans avec distance géométrique L2 en niveau de gris

for choix=3:5

  %% Méthode 1 ou 2 : Algorithme Kmeans sur image
  if choix<=2

    % Pour une segmentation en niveau de gris
    disp('Premier jeu de données')
    points2=zeros(n1*m1,1);
    points=I(:);

    %%Taille du jeu de données
    disp('nbre de points')
    [n,m]=size(points);

    disp('Test du Kmeans')
    if choix==1
      disp('Distance L1')
      [IDX,C]=kmeans(points,k,'start','uniform','distance','cityblock');
    else 
      disp('Distance L2')
      [IDX,C]=kmeans(points,k,'start','uniform');
    end

    figure
    hold on
    colormap('gray');
    I4=reshape(IDX,n1,m1);
    I4=ipermute(I4,[1,2,3]);
    I5=uint8(I4);
    imagesc(I5)

    d = edge(I4,filtre,seuil);  
    %d = bwareaopen(d,40);
    %imshow(d)

    if(choix == 1)
      %title('Kmeans i1');
      saveName = [ imageNameShort, '_', num2str(k), '_Kmeans_i1_', filtre];
    else
      %title('Kmeans i2');
      saveName = [ imageNameShort, '_', num2str(k), '_Kmeans_i2_', filtre];
    end
    saveas(gcf, saveName, 'jpg');

    iout=I./255;
    BW=d;
    iout(:,:,1) = iout;                           %# Initialize red color plane
    iout(:,:,2) = iout(:,:,1);                    %# Initialize green color plane
    iout(:,:,3) = iout(:,:,1);                    %# Initialize blue color plane
    iout(:,:,1) = min(iout(:,:,1) + BW, 1.0);     %# Add edges to red color plane
    figure;
    imshow(iout);
    if(choix == 1)
      title('Kmeans i1');
      saveName = [imageNameShort, '_i+c_', num2str(k), '_Kmeans_i1_', filtre];
    else
      title('Kmeans i2');
      saveName = [imageNameShort, '_i+c_', num2str(k), '_Kmeans_i2_', filtre];
    end
    saveas(gcf, saveName, 'jpg');

  elseif choix <= 4
    %% Méthode 3 ou 4 : Global Kmeans avec distance niveau de gris L1 ou L2
    % Pour une segmentation en niveau de gris
    disp('Premier jeu de données')
    points2=zeros(n1*m1,1);
    points=I(:);

    %%Taille du jeu de données
    disp('nbre de points')
    [n,m]=size(points);

    disp('Initialisation des Centres');
    IDX = otsu(I,k);

    Centre=zeros(k,1);
    for i=1:k
      ii=find(IDX==i);
      Centre(i)=floor(mean(points(ii)));
    end

    disp('Test du Global Kmeans L1 ou L2')
    % sans Otsu
    %[Er,M,nb] = GlobalKmeans(points, [], k, 0, 0, 0, choix-2);
    % avec Otsu
    [Er,M,nb] = GlobalKmeans2(points, [], k, 0, 0, 0, choix-2, Centre);
    Centre
    M
    %dyn=1 fast global kmeans ,
    %dyn=4 global kmeans 
    %dyn=0 for random initialisation

    [distance]=sqdist(M',points',choix-2);
    [~,IDX]=min(distance',[],2);

    figure
    colormap('gray');
    I4=reshape(IDX,n1,m1);
    I4=ipermute(I4,[1,2,3]);
    imagesc(I4)
    axis off
    d = edge(I4,filtre,seuil);  
    %d = bwareaopen(d,40);
    %imshow(d)

    if choix==3
      %title('Global Kmeans i1')
      saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_i1_', filtre];
    else
      %title('Global Kmeans i2')
      saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_i2_', filtre];
    end
    saveas(gcf, saveName, 'jpg');

     iout=I./255;
%     BW=d;
     iout(:,:,1) = iout;                           %# Initialize red color plane
     iout(:,:,2) = iout(:,:,1);                    %# Initialize green color plane
     iout(:,:,3) = iout(:,:,1);                    %# Initialize blue color plane
%     iout(:,:,1) = min(iout(:,:,1) + BW, 1.0);     %# Add edges to red color plane
     figure;
     imshow(iout);
     hold on;

    [ii,jj]=find(d==1);
    plot(jj,ii,'r.','LineWidth',1)
     
    if choix==3
      %title('Global Kmeans i1')
      saveName = [ imageNameShort, '_i+c_', num2str(k), '_GlobalKmeans_i1_', filtre];
    else
      %title('Global Kmeans i2')
      saveName = [ imageNameShort, '_i+c_', num2str(k), '_GlobalKmeans_i2_', filtre];
    end
    saveas(gcf, saveName, 'jpg');

  else 

    %% Méthode 5 ou 6 : Global Kmeans avec distance géométrique
    %Pour une segmentation géométrique + niveau de gris
    disp('Deuxième jeu de données')
    Data=zeros(n1*m1,3);
    for i=1:n1
      for j=1:m1
        Data((i-1)*m1+j,:)=[i/n1,j/m1,I(i,j)/255];
      end
    end
    points=Data;

    %%Taille du jeu de données
    disp('nbre de points')
    [n,m]=size(points);

    disp('Initialisation des Centres');
    IDX = otsu(I,k);
    Centre=zeros(k,3);
    for i=1:k
        ii=find(IDX==i);
        Centre(i,1:2)=mean(Data(ii,1:2));
        Centre(i,3)=mean(Data(ii,3));
    end
    
    disp('Test du Global Kmeans Géométrique L')
    % sans Otsu
    [Er,M,nb] = GlobalKmeans(points,[],k,0,0,0,choix-4);
    % avec Otsu
    [Er,M,nb] = GlobalKmeans2(Data,[],k,0,0,0,choix-4,Centre);
    %dyn=1 fast global kmeans ,
    %dyn=4 global kmeans 
    %dyn=0 for random initialisation

    [distance]=sqdist(M',points',choix-4);
    [~,IDX]=min(distance',[],2);

    figure
    colormap('gray');
    I4=reshape(IDX,m1,n1);
    I4=ipermute(I4,[2,1,3]);
    imagesc(I4)

    d = edge(I4,filtre,seuil);  
    %d = bwareaopen(d,40);
    %imshow(d)

    if choix==5
      %title('Global Kmeans g2i1')
      saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_g2i1_', filtre];
    else
      %title('Global Kmeans g2i2')
      saveName = [ imageNameShort, '_', num2str(k), '_GlobalKmeans_g2i2_', filtre];
    end
    saveas(gcf, saveName, 'jpg');

    iout=I./255;
%    BW=d;
    iout(:,:,1) = iout;                           %# Initialize red color plane
    iout(:,:,2) = iout(:,:,1);                    %# Initialize green color plane
    iout(:,:,3) = iout(:,:,1);                    %# Initialize blue color plane
%    iout(:,:,1) = min(iout(:,:,1) + BW, 1.0);     %# Add edges to red color plane
    figure;
    imshow(iout);
    hold on;
    [ii,jj]=find(d==1);
    plot(jj,ii,'r.','LineWidth',1)
    
    if choix==5
      %title('Global Kmeans g2i1')
      saveName = [ imageNameShort, '_i+c_', num2str(k), '_GlobalKmeans_g2i1_', filtre];
    else
      %title('Global Kmeans g2i2')
      saveName = [ imageNameShort, '_i+c_', num2str(k), '_GlobalKmeans_g2i2_', filtre];
    end
    saveas(gcf, saveName, 'jpg');

  end %if

end % for choix=1:6

%close all

end % for k=3:8 

end %for filtre