function  tracerErreur(nmax )
%TRACERERREUR Summary of this function goes here
%   Detailed explanation goes here
err=[];
h=[];
for i=3:nmax
    [c,~,e,d]=maillage_carre(i);
    [A,b]=assemblageQuadrangle(c,e,d,@f);
    u=A\b;
    h=[h,1/(i-1)];
    err=[err,(1/(i-1))*erreur(u,c)];
end
loglog(h,err,h,h.^2);
title 'Erreur de la méthode aux éléments finis'
legend 'erreur' 'segment de pente 2'
