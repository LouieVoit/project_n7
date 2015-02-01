function M = im2mask(I,method)
% INPUTS :  
% I : initial image
% method : 1 -> Global Kmeans
%          2 -> kmeans matlab
% OUPUTS :
% mask : mask (format double) used in the initialisation of Chan Vese algorithm

I = double(I(:,:,1));
k=3; %Kmeans parameter
points = I(:);
if (method == 1)
    dist=2; %Dist used in GKmeans
    %- Initialisation of Kmeans with Otsu centroid
    IDX=otsu(I,k);
    centre=zeros(k,1);
    for i=1:k
        ind = find(IDX==i);
        centre(i)=mean(points(ind));
    end
    %- Kmeans
    [Er,C,iter] = GKmeans(points, [], k, dist, centre);

    %- Display
    disp('########################');
    disp('Initial centroid');
    centre
    disp('########################');
    disp('Final centroid');
    C
    disp('########################');
    disp('Iter');
    iter
    distance = sqdist(C',points',dist);
    [~,M] = min(distance,[],1);
else
    %- Kmeans
    [M,C,sumd]=kmeans(points,k,'start','uniform','distance','cityblock');
%     [M,C,sumd]=kmeans(points,k,'start','uniform');

    %- Display
    disp('########################');
    disp('Centroid');
    C
    disp('########################');
    disp('sums of point-to-centroid distances');
    sumd
end
M = reshape(M,size(I,1),size(I,2));
%- M is a size(I,1)*size(I,2) matrix; M(i,j) == c if point of coordinates
%(i,j) belongs to cluster c; c in [1,k];

%- Search the cluster id of the tooth (k=3 -> 3 cluster thus 1 id
% k=4 -> 4 clusters thus 2 id
Caux = C;
idTooth = [];
for i=1:(k-2)
    [~,id] = max(Caux);
    Caux(id) = 0;
    idTooth=[idTooth,id];
end
%- Mask creation for Chan-Vese algorithm
for i=1:k
%     if (ismember(i,idTooth))
%         M(find(M==i))=1;
%     else
%         M(find(M==i))=0;
%     end
        M(find(M==i))=C(i);
end
