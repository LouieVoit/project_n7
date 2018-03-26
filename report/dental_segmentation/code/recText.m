function T = recText(I,dirG,dirA)
%% Doc
% INPUTS : I : dental radiography image
% dirG and dirA are paths to the gum and other part database matrix
% OUPUTS : T : black and white mask (the gum is black, other parts are white).
%% Initilisation
I = I(:,:,1); 
[ni,mi] = size(I);
T = zeros(ni,mi);
load(dirA);
load(dirG);
nTextG = size(G,1);
nTextA = size(A,1);
w = sqrt(size(G{1},2));
nText = nTextA + nTextG;
%% Reconnaissance Texture
IB=split_into_blocs(I,ones(w,w));
p = size(IB,3);
IBC=zeros(w^2,p);
for j=1:p
    tmp=IB(:,:,j);
    IBC(:,j)=tmp(:);
end
Proj=zeros(nText,p);
coeffProj=3;
for t=1:nTextG
    tmp=G{t};
    mean=tmp(w^2+1,:);
    B=tmp(1:w^2,:);
    tmp=IBC-repmat(mean',1,p);
    Proj(t,:)=sum(abs(B(:,1:coeffProj)'*tmp),1); %k*p
end
for t=(nTextG+1):(nText)
    tmp=A{t-nTextG};
    mean=tmp(w^2+1,:);
    B=tmp(1:w^2,:);
    tmp=IBC-repmat(mean',1,p);
    Proj(t,:)=sum(abs(B(:,1:coeffProj)'*tmp),1); %k*p
end
[~,text]=min(Proj,[],1);
text=(text<=nTextG);
tmp=ones(w,w,p);
for k=1:p
    tmp(:,:,k)=tmp(:,:,k)*text(k)*255;
end
Iapp=uint8(replace_blocs(tmp,ni,mi));
figure(1);
imshow(Iapp);
T=Iapp;
end

