function mask=ellipse(xa,ya,xb,yb,C,Nb,I)
%% Doc
% INPUTS : (xa,ya) coordinates (size(xa)=2=size(ya)) of the first axe
% (xb,yb) coordinates of the second axe
% C : color of the ellipse
% Nb : number of point to draw the ellipse
% I : image on which to draw the ellipse
% OUTPUT : black and white mask for ChanVese initialisation

%%
    %-- Check the number of input arguments
    if (nargin <7)
        error('Not enough input arguments');
    end
    
    %-- Initialisation
    x0 = mean(xa);
    y0 = mean(ya);
    ra = sqrt(diff(xa)^2+diff(ya)^2)/2;
    rb = sqrt(diff(xb)^2+diff(yb)^2)/2;
    aux=[xa(2)-xa(1) ya(2)-ya(1)];
    aux=aux/norm(aux);
    aux2=[0 1];
    co=dot(aux,aux2);
    si=sqrt(1-co^2);
    theta = linspace(0,2*pi,Nb);

    %-- Parametrisation de l'ellipse
    x = rb*cos(theta);
    y = ra*sin(theta);

    %-- Changement de repère
    X = x*co-y*si;
    Y = x*si+y*co;
    X = X+x0;
    Y = Y+y0;

    %-- Plot
    h = line(X,Y);
    set(h,'color',C);
    set(h,'linestyle','--');
    
    %-- Compute mask
    ny=size(I,1);
    nx=size(I,2);
    mask = zeros(ny,nx);
    X = round(X);
    Y = round(Y);
    X(find(X<1))=1;X(find(X>nx))=nx;
    Y(find(Y<1))=1;Y(find(Y>ny))=ny;
    mask(sub2ind(size(mask),Y,X))=1;
    mask = imfill(mask,'holes');

