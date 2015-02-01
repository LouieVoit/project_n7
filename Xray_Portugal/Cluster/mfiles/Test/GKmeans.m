
function [Er,M,iter] = GKmeans(X,T,kmax,distL,centre)
% kmeans - clustering with k-means (or Generalized Lloyd or LBG) algorithm
%
% [Er,M,nb] = GlobalKmeans(X,T,kmax,distL,centre)
%
% X    - (n x d) d-dimensional input data
% T    - (? x d) d-dimensional test data
% kmax - (maximal) number of means
% distL - 1 -> distance L1 ; 2 -> distance L2
% centre - centre used for the initialisation 
%
% returns
% Er - sum of squared distances to nearest mean (second column for test data)
% M  - (k x d) matrix of cluster centers; k is computed dynamically
%
% Nikos Vlassis & Sjaak Verbeek, 2001, http://www.science.uva.nl/~jverbeek
 
Er=[]; TEr=[];              % error monitorring
 
disp('Dimension des donnees')
[n,d]     = size(X)
 
THRESHOLD = 1e-4;   % relative change in error that is regarded as convergence
nb        = 0;  
 

% initialize 
disp('Initialisation')
% disp('Use random subset of data as means') % use random subset of data as means
% k      = kmax;
% tmp    = randperm(n);
% M      = X(tmp(1:k),:);
disp('Use centroid from otsu algorithm') % use random subset of data as means
k      = kmax;
M      = centre;
 
Wnew=5;
Wold = realmax;
iter=1; 

while k <= kmax
    kill = [];
    
    % squared Euclidean distances to means; Dist (k x n)
    Dist = sqdist(M',X',distL);
    
    % Voronoi partitioning
    [Dwin,Iwin] = min(Dist',[],2);
    
    % error measures and mean updates
    Wnew = sum(Dwin);
    
    % update VQ's
    for i=1:size(M,1)
        I = find(Iwin==i);% EMPTY MATRIX
        if size(I,1)>d
            M(i,:) = mean(X(I,:));
        else
            kill = [kill; i];
        end
    end
    
    if 1-Wnew/Wold < THRESHOLD*(10-9*(k==kmax))
        if  k < kmax
            best_Er = Wnew;
            
            for i=1:n;
                Wold = Inf;
                Wtmp = Wnew;
                Mtmp = [M; X(i,:)];
                while (1-Wtmp/Wold) > THRESHOLD*10;
                    Wold = Wtmp;
                    Dist = sqdist(Mtmp',X',distL);
                    [Dwin,Iwin] = min(Dist',[],2);
                    
                    Wtmp = sum(Dwin);
                    for i = 1 : size(Mtmp,1)
                        I = find(Iwin==i);
                        if size(I,1)>d;
                            Mtmp(i,:) = mean(X(I,:)); end
                    end
                end
                if Wtmp < best_Er;   best_M = Mtmp; best_Er = Wtmp; end
            end
            
            M = best_M;
            Wnew = best_Er;
            if ~isempty(T); tmp=sqdist(T',M',distL); TEr=[TEr; sum(min(tmp,[],2))];end;
            Er=[Er; Wnew];
            k = k+1;
        else
            k = kmax+1;
        end
    end
    Wold = Wnew;
    iter=iter+1;
end
Er=[Er; Wnew];
if ~isempty(T); tmp=sqdist(T',M',distL); TEr=[TEr; sum(min(tmp,[],2))]; Er=[Er TEr];end;
M(kill,:)=[];