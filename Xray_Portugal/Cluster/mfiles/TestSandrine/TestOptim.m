clc
clear all
close all



I1=imread('rx4.jpg');
I=double(I1(:,:,1));
disp('Taille de l image')
[n1,m1,p]=size(I);


% Pour une segmentation en niveau de gris
disp('Premier jeu de donnï¿½es')
points2=zeros(n1*m1,1);
points=I(:);


% nb classe
k=5

% Initialisation des centres

IDX = otsu(I,k);
figure
 subplot(1,2,1)
 imagesc(I1)
 title(['Original data ' ]);
 subplot(1,2,2)
imagesc(IDX);
IDX2=IDX;

Centre=zeros(k,1);
for i=1:k
    ii=find(IDX==i);
    Centre(i)=floor(mean(points(ii)));
end
    
    



disp('M�thode Kmeans')
[Er,M,nb] = GlobalKmeans2(points,[],k,0,0,0,2,Centre)

[distance]=sqdist(M',points',1);
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
 title('Kmeans');
 
 
 disp('difference entre les 2 methods')
 nnz(I4-IDX2)/(n1*m1)*100
 
 
 
 
