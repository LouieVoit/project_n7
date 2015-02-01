close all;
load('ImageCouleur.mat');
I=rgb2gray(Image);
figure(1);
imshow(I);
[ni,mi]=size(I);
disp('################ Partie 1 ################');
%%
disp('############ Selection des trois regions ################');
rSR1 = getrect(figure(1));
rSR2 = getrect(figure(1));
rSR3 = getrect(figure(1));

%%
xmin=rSR1(1);
ymin=rSR1(2);
width=rSR1(3);
height=rSR1(4);
SR1=I(ymin:(ymin+height),xmin:(xmin+width));

%%
xmin=rSR2(1);
ymin=rSR2(2);
width=rSR2(3);
height=rSR2(4);
SR2=I(ymin:(ymin+height),xmin:(xmin+width));

%%
xmin=rSR3(1);
ymin=rSR3(2);
width=rSR3(3);
height=rSR3(4);
SR3=I(ymin:(ymin+height),xmin:(xmin+width));

%%
disp('############ Split block ################');
disp('valeur de w:');
w=5
aux=ones(w,w);
SPB1=split_into_blocs(SR1,aux);
SPB2=split_into_blocs(SR2,aux);
SPB3=split_into_blocs(SR3,aux);

%%
p = size(SPB1,3);
X1=zeros(p,w^2);
for j=1:p
    tmp=SPB1(:,:,j);
    X1(j,:)=tmp(:)';
end

p = size(SPB2,3);
X2=zeros(p,w^2);
for j=1:p
    tmp=SPB2(:,:,j);
    X2(j,:)=tmp(:)';
end

p = size(SPB3,3);
X3=zeros(p,w^2);
for j=1:p
    tmp=SPB3(:,:,j);
    X3(j,:)=tmp(:)';
end
%%
disp('############ PCA ################');
p=size(X1,1);
mean1 = mean(X1);
XC1 = X1 - repmat(mean1,p,1);
[B1,D1] = eig(XC1'*XC1/w^2);
[D1, ind] = sort(diag(D1), 1, 'descend');
B1 = B1(:,ind);

p=size(X2,1);
mean2 = mean(X2);
XC2 = X2 - repmat(mean2,p,1);
[B2,D2] = eig(XC2'*XC2/w^2);
[D2, ind] = sort(diag(D2), 1, 'descend');
B2 = B2(:,ind);

p=size(X3,1);
mean3 = mean(X3);
XC3 = X3 - repmat(mean3,p,1);
[B3,D3] = eig(XC3'*XC3/w^2);
[D3, ind] = sort(diag(D3), 1, 'descend');
B3 = B3(:,ind);


%%
disp('################ Partie 2 ################');
disp('valeur de k:');
k=5
disp('ratio eigenvalue:')
sum(D1(1:k))/sum(D1)
sum(D2(1:k))/sum(D2)
sum(D3(1:k))/sum(D3)

Imod=uint8(zeros(ni,mi));

IB=split_into_blocs(I,ones(w,w));
p = size(IB,3);
mean=mean1;
B=B1;
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
IBmod1=tmp;
tmp=uint8(replace_blocs(tmp,ni,mi));
Imod(:,1:mi/3)=tmp(:,1:mi/3);

IB=split_into_blocs(I,ones(w,w));
p = size(IB,3);
mean=mean2;
B=B2;
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
IBmod2=tmp;
tmp=uint8(replace_blocs(tmp,ni,mi));
Imod(:,(mi/3+1):(2*mi/3))=tmp(:,(mi/3+1):2*mi/3);

IB=split_into_blocs(I,ones(w,w));
p = size(IB,3);
mean=mean3;
B=B3;
IBC=zeros(w^2,p);
for j=1:p
    tmp=IB(:,:,j);
    IBC(:,j)=tmp(:);
end
IBC=IBC-repmat(mean',1,p);
IBC=B1(:,1:k)*B1(:,1:k)'*IBC+repmat(mean',1,p); %w^2*p
tmp=zeros(w,w,p);
for j=1:p
    tmp(:,:,j)=reshape(IBC(:,j),w,w);
end
IBmod3=tmp;
tmp=uint8(replace_blocs(tmp,ni,mi));
Imod(:,(2*mi/3+1):mi)=tmp(:,(2*mi/3+1):mi);

close;
figure(1);
subplot(4,1,1);
imshow(I);
subplot(4,1,2);
imshow(Imod);

%% Appartenance a une texture

disp('############ Appartenance ################');

Iapp=uint8(zeros(ni,mi));


%% 
disp('################# Erreur coefficient projection ################');

IB=split_into_blocs(I,ones(w,w));
p = size(IB,3);
IBC=zeros(w^2,p);
for j=1:p
    tmp=IB(:,:,j);
    IBC(:,j)=tmp(:);
end
IBC1=IBC-repmat(mean1',1,p);
IBC2=IBC-repmat(mean2',1,p);
IBC3=IBC-repmat(mean3',1,p);
Proj=zeros(3,p);
coeffProj=1;
Proj(1,:)=sum(abs(B1(:,1:coeffProj)'*IBC1),1); %k*p
Proj(2,:)=sum(abs(B2(:,1:coeffProj)'*IBC2),1); 
Proj(3,:)=sum(abs(B3(:,1:coeffProj)'*IBC3),1);
[~,text]=min(Proj,[],1);
tmp=ones(w,w,p);
for k=1:p
    tmp(:,:,k)=tmp(:,:,k)*text(k)*85;
end
Iapp=uint8(replace_blocs(tmp,ni,mi));
subplot(4,1,3);
imshow(Iapp);
%% 
disp('################# Erreur norme L2 ################');
IB=split_into_blocs(I,ones(w,w));
p=size(IB,3);
tmp=ones(w,w,p);
er1=IB-IBmod1;
er2=IB-IBmod2;
er3=IB-IBmod3;

err=zeros(3,p);
for k=1:p
    tmp1=er1(:,:,k);
    tmp2=er2(:,:,k);
    tmp3=er3(:,:,k);    
    err(:,k)=[norm(tmp1),norm(tmp2),norm(tmp3)]';
    [~,ind]=min(err(:,k));
    tmp(:,:,k)=tmp(:,:,k)*ind*85;
end

Iapp=uint8(replace_blocs(tmp,ni,mi));
subplot(4,1,4);
imshow(Iapp);










