close all;
% load('ImageCouleur.mat');
I=imread('rx1.bmp');
I=double(I(:,:,1));
%I=rgb2gray(I);
disp('nombre texture :');
nText=3
nFig=1;
figure(nFig);
imshow(I);
[ni,mi]=size(I);
disp('################ Partie 1 ################');
%%
disp('############ Selection des regions ################');
rSR=zeros(4,nText);
for t=1:nText
    rSR(:,t) = getrect(figure(1))';
end
%%
disp('############ Split block et PCA ################');
disp('valeur de w:');
w=2
aux=ones(w,w);
for t=1:nText
    xmin=rSR(1,t);
    ymin=rSR(2,t);
    width=rSR(3,t);
    height=rSR(4,t);
    SPB=split_into_blocs(I(ymin:(ymin+height),xmin:(xmin+width)),aux);
    p = size(SPB,3);
    X=zeros(p,w^2);
    for j=1:p
        tmp=SPB(:,:,j);
        X(j,:)=tmp(:)';
    end
    m = mean(X);
    XC = X - repmat(m,p,1);
    [B,D] = eig(XC'*XC/w^2);
    [D, ind] = sort(diag(D), 1, 'descend');
    B = B(:,ind);
    name=strcat('B',num2str(t));
    assignin('base',name,B);
    name=strcat('D',num2str(t));
    assignin('base',name,D);
    name=strcat('mean',num2str(t));
    assignin('base',name,m);
end
%%
disp('################ Partie 2 ################');
disp('valeur de k:');
k=2
disp('ratio eigenvalue:')
for t=1:nText
    tmp=evalin('base',strcat('D',num2str(t)));
    sum(tmp(1:k))/sum(tmp)
end
for t=1:nText
    IB=split_into_blocs(I,ones(w,w));
    p = size(IB,3);
    mean=evalin('base',strcat('mean',num2str(t)));
    B=evalin('base',strcat('B',num2str(t)));
    IBC=zeros(w^2,p);
    for j=1:p
        tmp=IB(:,:,j);
        IBC(:,j)=tmp(:);
    end
    IBC=IBC-repmat(mean',1,p);
    IBC=B(:,1:k)*B(:,1:k)'*IBC+repmat(mean',1,p); %w^2*p
    tmp=zeros(w,w,p);
    for j=1:p
        tmp(:,:,j)=reshape(IBC(:,j),w,w);
    end
    name=strcat('IBmod',num2str(t));
    assignin('base',name,tmp);
    IBmod1=tmp;
    Imod=uint8(replace_blocs(tmp,ni,mi));
    nFig=nFig+1;
    figure(nFig);
    imshow(Imod);
end

%% Appartenance a une texture

disp('############ Appartenance ################');

%% 
disp('################# Erreur coefficient projection ################');

IB=split_into_blocs(I,ones(w,w));
p = size(IB,3);
IBC=zeros(w^2,p);
for j=1:p
    tmp=IB(:,:,j);
    IBC(:,j)=tmp(:);
end
Proj=zeros(nText,p);
coeffProj=1;
for t=1:nText
    mean=evalin('base',strcat('mean',num2str(t)));
    B=evalin('base',strcat('B',num2str(t)));
    tmp=IBC-repmat(mean',1,p);
    Proj(t,:)=sum(abs(B(:,1:coeffProj)'*tmp),1); %k*p
end
[~,text]=min(Proj,[],1);
tmp=ones(w,w,p);
for k=1:p
    tmp(:,:,k)=tmp(:,:,k)*text(k)*255/nText;
end
Iapp=uint8(replace_blocs(tmp,ni,mi));
nFig=nFig+1;
figure(nFig);
imshow(Iapp);

%% 
disp('################# Erreur norme L2 ################');
IB=split_into_blocs(I,ones(w,w));
p=size(IB,3);
err=zeros(3,p);
for t=1:nText
    IBmod=evalin('base',strcat('IBmod',num2str(t)));
    er=IB-IBmod;
    for k=1:p
        tmp=er(:,:,k);
        err(t,k)=norm(tmp);
    end
end
tmp=ones(w,w,p);
for k=1:p
    [~,ind]=min(err(:,k));
    tmp(:,:,k)=tmp(:,:,k)*ind*255/nText;
end    
Iapp=uint8(replace_blocs(tmp,ni,mi));
figure;
nFig=nFig+1;
figure(nFig);
imshow(Iapp);










