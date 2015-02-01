function I = replace_blocs(B,m,n)
% REPLACE_BLOCS -- Inverse operation of split_into_blocs
%
%  Usage
%   I = replace_blocs(B,m,n)
%
%  Input
%   B  3-d input matrix of size (a,b,k) where k is the number of blocs
%   m,n output image size
%  Output
%   I  	2-d output matrix
%   
%
%  Description
%   The blocs are replaced column by column from top to bottom and left to right.
%
% See Also
%   SPLIT_INTO_BLOCS, RESHAPE, WAV2SQBLKS

% initilaise l' image
I = zeros(m,n);
% taille des blocs
[mk,nk,nbB] = size(B);

% warning si on omet des bords
if ( rem(m,mk)~=0 | rem(n,nk)~=0 )
    disp('REPLACE_BLOCS : Warning');
    disp('Les bords ont ete ignores dans le decoupage par blocs.');
end

% nombre de blocs dans l'image
mB = floor(m/mk); nB = floor(n/nk);

% crop l'image pour fitter les blocs
I = I(1:mB*mk,1:nB*nk);

i1 = [1:mk:(mB-1)*mk+1]'*ones(1,nB);
j1 = ones(mB,1)*[1:nk:(nB-1)*nk+1];
for im=1:mk,
   i = i1(:)+im-1;
   for jn=1:nk,
      j = j1(:)+jn-1;
      I((j-1)*mB*mk+i) = B(im,jn,:);
   end
end