function B = split_into_blocs(I,ker)
% SPLIT_INTO_BLOCS -- Split a 2-dimensional matrix into smaller blocs
%
%  Usage
%   B = split_into_blocs(I,ker)
%
%  Input
%   I  	2-d input matrix
%   ker	noyau (binaire)
%  Output
%   B  3-d output matrix of size (size(ker),k) where k is the number of blocs
%
%  Description
%   Split the input matrix into smaller blocs. The blocs are
%	read column by column from top to bottom and left to right.
%
% See Also
%   SPLIT_INTO_BLOCS, RESHAPE, WAV2SQBLKS

% taille de l'image
[m,n] = size(I);
% taille des blocs
[mk,nk] = size(ker);

% warning si on omet des bords
if ( rem(m,mk)~=0 | rem(n,nk)~=0 )
    disp('SPLIT_INTO_BLOCS : Warning');
    disp('Les bords ont ete ignores dans le decoupage par blocs.');
end

% nombre de blocs dans l'image
mB = floor(m/mk); nB = floor(n/nk);
nbB = mB*nB;

% crop l'image pour fitter les blocs
I2 = I(1:mB*mk,1:nB*nk);

% init la matrice 3d des nbB blocs
B = zeros(mk,nk,nbB);

i1 = [1:mk:(mB-1)*mk+1]'*ones(1,nB);
j1 = ones(mB,1)*[1:nk:(nB-1)*nk+1];
for im=1:mk,
   i = i1(:)+im-1;
   for jn=1:nk,
      j = j1(:)+jn-1;
      B(im,jn,:) = I2((j-1)*mB*mk+i);
   end
end
