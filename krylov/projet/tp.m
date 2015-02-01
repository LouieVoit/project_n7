function tp()
    %%
    %Choix de la matrice
    %load 'mat3.mat'
    %load('pde225.mat')
    %load('hydcar20.mat')
    %load 'mat3';
    [A,~]=bwm200;
    n=size(A,2);
    B=(1:n)';
    %Preconditionnement
    M1=eye(n);M2=eye(n);
%     M1=eye(n);M2=lu(A);
%     setup.type='nofill';    
%     [M1,M2]=ilu(A,setup);
    %% Calcul
 
    tic
    [~,flag,relres,iter,resvec1] = dqgmres(A,B,zeros(n,1),90,600,1e-2,M1,M2);
    fprintf('---------- dqgmres ------------\n');
    fprintf('iterations : %d\n', iter);
    fprintf('residu : %e\n', relres);
    fprintf('flag :%d\n', flag);
    toc
     tic
    [~,flag,relres,iter,resvec2] = dqgmres(A,B,zeros(n,1),90,600,1e-4,M1,M2);
    fprintf('---------- dqgmres ------------\n');
    fprintf('iterations : %d\n', iter);
    fprintf('residu : %e\n', relres);
    fprintf('flag :%d\n', flag);
    toc
     tic
    [~,flag,relres,iter,resvec3] = dqgmres(A,B,zeros(n,1),90,600,1e-6,M1,M2);
    fprintf('---------- dqgmres ------------\n');
    fprintf('iterations : %d\n', iter);
    fprintf('residu : %e\n', relres);
    fprintf('flag :%d\n', flag);
    toc
    tic
    [~,flag,relres,iter,resvec4] = dqgmres(A,B,zeros(n,1),90,600,1e-8,M1,M2);
    fprintf('---------- dqgmres ------------\n');
    fprintf('iterations : %d\n', iter);
    fprintf('residu : %e\n', relres);
    fprintf('flag :%d\n', flag);
    toc
    
    

    
    %%
    %Plot
    hold on;
    beta=norm(M2\(M1\B));
    semilogy(resvec1/beta,'k--');
    semilogy(resvec2/beta,'r--');
    semilogy(resvec3/beta,'b--');
    semilogy(resvec4/beta,'g--');


%     semilogy(resvec4/beta,'ro');
%     semilogy(resvec5/beta,'bo');
    legend '-2' '-4' '-6' '-8'
end

