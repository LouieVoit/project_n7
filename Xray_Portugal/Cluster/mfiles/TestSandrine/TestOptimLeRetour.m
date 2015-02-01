clc
clear all
close all



I1=imread('rx3.jpg');
I=double(I1(:,:,1));
disp('Taille de l image')
[n1,m1,p]=size(I);



% Pour une segmentation en niveau de gris
disp('Premier jeu de donnï¿½es')
points2=zeros(n1*m1,1);
points=I(:);


%Pour une segmentation gï¿½omï¿½trique + niveau de gris
 disp('Deuxiï¿½me jeu de donnï¿½es')
Data=zeros(n1*m1,3);
for i=1:n1
  for j=1:m1
      Data((i-1)*m1+j,:)=[i/n1,j/m1,I(i,j)/255];
  end
end


% nb classe
k=4

% Initialisation des centres

IDX = otsu(I,k);
Centre=zeros(k,3);
for i=1:k
    ii=find(IDX==i);
    Centre(i,1:2)=mean(Data(ii,1:2));
    Centre(i,3)=mean(Data(ii,3));
end




%% Mï¿½thode 3 : Global Kmeans avec distance gï¿½omï¿½trique
disp('Test du Global Kmeans Gï¿½omï¿½trique L')
[Er,M,nb] = GlobalKmeans2(Data,[],k,0,0,0,1,Centre);
%dyn=1 fast global kmeans ,
%dyn=4 global kmeans 
% dyn=0 for random initialisation


[distance]=sqdist(M',Data',1);
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

