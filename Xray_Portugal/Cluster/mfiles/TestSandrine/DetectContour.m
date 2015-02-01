%%%%%%%%%%%%
%% Detection de contours
%%%%%%%%%%%%


 % Detection des contours
 
 Mat_class=I4;

[n,m]=size(Mat_class);


List_contour=[];
% Balayage horizontal
for i=1:n
    for j=2:2:m
        if Mat_class(i,j)~=Mat_class(i,j-1)
            List_contour=[List_contour;i,j];
        end
    end
end         
size(List_contour)

%Balayage vertical
for j=1:m
    for i=2:2:n
        if Mat_class(i,j)~=Mat_class(i-1,j)
            List_contour=[List_contour;i,j];
        end
    end
end

size(List_contour)

% Création de la matrice de contours
Mat_contour=zeros(n,m);

p=size(List_contour,1);
for i=1:p
    Mat_contour(List_contour(i,1),List_contour(i,2))=255;
end
% 
%  figure
%  imshow(Mat_contour)
%  title(' Contour detection result with Spectral Clustering');



 figure
 hold on
 colormap('gray');
 subplot(1,2,1)
 imagesc(I4)
 title(['Original data ' ]);
 subplot(1,2,2)
 Mat_contour=uint8(Mat_contour);
imshow(Mat_contour) 
 rotate3d on
 title(' Contour detection with Spectral Clustering');
