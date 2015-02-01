function [ grad,alpha ] = eta( i,sommets,coordinates )
%ETA calcul des valeurs de la fonction eta sur un sommet i du triangle dont
%les sommets sont dans sommets, les coordonnées des sommets étant stockés
%dans coordinates

X=[coordinates(sommets(1),1),coordinates(sommets(2),1),coordinates(sommets(3),1)];
   Y=[coordinates(sommets(1),2),coordinates(sommets(2),2),coordinates(sommets(3),2)];
   alpha = det([X(2)-X(1) , X(3)-X(1) ; Y(2)-Y(1) , Y(3)-Y(1) ]);
   switch i
       case sommets(1)
           grad = [Y(2)-Y(3) ; X(3)-X(2) ];
       case sommets(2)
           grad = [Y(3)-Y(1) ; X(1)-X(3) ];
       case sommets(3)
           grad = [Y(1)-Y(2) ; X(2)-X(1) ];
   end
   grad = grad/alpha;

end

