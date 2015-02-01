% Résolution de l'équation elliptique
%   - nabla (c.grad u) + a.u = f


clear all
close all

% pour tracer les courbes de décroissance de la norme du résidu 
% des différents maillages avec des couleurs différentes
couleur = ['g', 'r', 'c', 'm'];

geom='tubeG';
boundary='tubeB';
source='tubeF';

% La géométrie du problème
% commenter ces 3 lignes si pénurie de licences Matlab
figure(1);
pdegplot(geom);
axis equal;

% Choix du niveau de raffinage : on effectuera autant de résolutions que de
% niveaux de raffinage
nR = input('Niveau de raffinage < 4 : '); 

while nR >= 4
  nR = input('Niveau de raffinage < 4 : ');
end

% Choix du préconditionneur pour le test courant
choix = menu( 'Test Gradient Conjugue Préconditionné', ...
              'sans','diagnonal','cholesky incomplet sans fill-in',...
              'cholesky incomplet avec tolérance','fin');

while choix < 5

  close all;
% Création du maillage
% commenter la ligne suivante si pénurie de licences Matlab
  [p,e,t] = initmesh(geom);

% choix du seuil dans le cas de la factorisation incomplète de Cholesky avec
% treshold
  if choix == 4
    DropTol = input('Drop Tolerance (réel positif) :  ') ;
  end

% Boucle sur les niveaux de raffinage 
 for k=0:nR

% commenter cette section si pénurie de licences Matlab
% -- début section

    % Raffinage
    if k > 0 
      [p,e,t] = refinemesh(geom,p,e,t);
    end

    % Dessin du maillage
    figure(2);
    pdemesh(p,e,t), axis equal
    xlabel(['number of triangles = ' num2str(size(t,2))]);
    disp('fin construction du maillage : taper une touche');
    pause

    a=0.0;
    c=setupC(p,t);
% -- fin section

% Construction de la matrice de rigidité ainsi que du
% second membre
% problème résolu - nabla(c.grad u ) + a.u = f
% commenter la ligne suivante si pénurie de licences Matlab
    [A,b]= assempde(boundary,p,e,t,c,a,source);

% décommenter la section suivante si pénurie de licences Matlab
% -- début section
%    switch k
%      case 0
%        load mat0;
%      case 1
%        load mat1;
%      case 2
%        load mat2;
%      case 3
%        load mat3;
%      otherwise
%        disp('impossible');
%    end
% -- fin section

    n = size(A,1);

% Définition des paramètres gouvernant le critère d'arrêt
    tol=1.e-10; maxit = floor(n/2);

% Construction du le préconditionneur M = M1*M2

    % tic
    timep=cputime;

    switch choix

      case 1,
        % Sans Préconditionnement
        M1=eye(n);
        M2=eye(n);
      case 2,
        % Diagonal
        M1=diag(diag(A));
        M2=eye(n);
      case 3,
        % Cholesky Incomplet sans remplissage
        M1=ichol(A);
        M2=M1';

      case 4,
        % Cholesky Incomplet avec treshold
        M1= ichol(A, struct('type','ict','droptol',DropTol,'michol','off'));
        M2=M1';

    end

    % tac
    timep=cputime-timep;

    if choix >= 3

      % Afficher la structure de la matrice dans la partie triangulaire
      % supérieure et celle du préconditionneur dans la partie triangulaire
      % inférieure.

     spy(triu(A)+M1);

    end

%    Résolution du système préconditionné avec CG/GMRES
    timer=cputime;
            [x,~,relres,iter,resrec]=pcg(A,b,[],tol,maxit,M1,M2);
    timer=cputime-timer;
    
% Dessin de la solution sur la géométrie
% commenter les 4 lignes suivantes si pénurie de licences Matlab
    figure(4)
    Titre = [ 'Solution' ];
    pdeplot(p,e,t,'xydata',x, 'title', Titre, 'colormap','jet', ...
            'mesh','off','contour','off','levels',20), axis equal

    fprintf(' niveau de Raffinage : %5d \n',k);
    fprintf(' Taille du probleme : %5d \n',n);
    %fprintf(' Estimation du conditionnement : %3.1e ', condest(R\(R'\A));
    fprintf(' - Nb iterations : %4d \n' ,iter);
    %if choix >= 3
    %  fprintf(' - dens(L) : %3.1e \n' ,nnz(R)/n);
    %end
    fprintf(' - CPU time pour la construction du préconditionneur : %3.1e s \n',timep);
    fprintf(' - CPU time pour la résolution : %3.1e s \n',timer);
    fprintf(' - CPU time : %3.1e s \n',timer + timep);
%
% Afficher l'historique de convergence en les superposant pour les différentes
% finesse de maillage
     figure(5)
     semilogy(resrec/norm(b),couleur(k+1));
     hold on
     disp('fin résolution pour ce maillage : taper une touche');
     pause
  end % for k

disp('nouveau calcul');
 choix = menu( 'Test Gradient Conjugue Préconditionné', ...
               'sans','diagnonal','cholesky incomplet sans fill-in',...
               'cholesky incomplet avec tolérance','fin');

end
close all;
