function tp1(X,Y,numDivision )
    if (isempty(X) && isempty(Y) )
        [X,Y]=saisi_points;
    end
    close;
    %pas constant
    %Construction de liste t
    liste_t=zeros(length(X));
    for j=2:(length(X))
        par=1;
        liste_t(j)=liste_t(j-1)+par;
    end
    pas=(liste_t(length(liste_t))-liste_t(1))/numDivision;
    liste_eval = liste_t(1):pas:liste_t(length(X));
    numEval = length(liste_eval);
    X_res = zeros(1,numEval);
    Y_res = zeros(1,numEval);
    i=1;
    for t=liste_eval
        p_t=interpolation(X,Y,liste_t,t);
        X_res(i)=p_t(1);
        Y_res(i)=p_t(2);
        i=i+1;
    end 
    subplot(221);
    hold on;
    plot(X_res,Y_res);
    plot(X,Y,'r+')
    title 'Pas constant'   
    %pas longueur arc
    %Construction de liste t
    liste_t=zeros(length(X));
    for j=2:(length(X))
        par=(norm([X(j)-X(j-1);Y(j)-Y(j-1)]));
        liste_t(j)=liste_t(j-1)+par;
    end
    pas=(liste_t(length(liste_t))-liste_t(1))/numDivision;
    liste_eval = liste_t(1):pas:liste_t(length(X));
    numEval = length(liste_eval);
    X_res = zeros(1,numEval);
    Y_res = zeros(1,numEval);
    i=1;
    for t=liste_eval
        p_t=interpolation(X,Y,liste_t,t);
        X_res(i)=p_t(1);
        Y_res(i)=p_t(2);
        i=i+1;
    end 
    subplot(222);
    hold on;
    plot(X_res,Y_res);
    plot(X,Y,'r+');
    title 'Pas longueur arc'
    %pas centripédale
    %Construction de liste t
    liste_t=zeros(length(X));
    for j=2:(length(X))
        par=sqrt(norm([X(j)-X(j-1);Y(j)-Y(j-1)]));
        liste_t(j)=liste_t(j-1)+par;
    end
    pas=(liste_t(length(liste_t))-liste_t(1))/numDivision;
    liste_eval = liste_t(1):pas:liste_t(length(X));
    numEval = length(liste_eval);
    X_res = zeros(1,numEval);
    Y_res = zeros(1,numEval);
    i=1;
    for t=liste_eval
        p_t=interpolation(X,Y,liste_t,t);
        X_res(i)=p_t(1);
        Y_res(i)=p_t(2);
        i=i+1;
    end 
    subplot(223);
    hold on;
    plot(X_res,Y_res);
    plot(X,Y,'r+')   
    title 'Pas centripedale'
    %pas tchebychef
    %Construction de liste t
    liste_t=zeros(1,length(X));
    n=length(X);
    for j=1:n
        liste_t(j)=cos((2*j-1)*pi/(2*n))*(X(n)-X(1))+(X(n)-X(1));
        liste_t(j)=liste_t(j)/2;
    end
    pas=(liste_t(length(liste_t))-liste_t(1))/numDivision;
    liste_eval = liste_t(1):pas:liste_t(length(X));
    numEval = length(liste_eval);
    X_res = zeros(1,numEval);
    Y_res = zeros(1,numEval);
    i=1;
    for t=liste_eval
        p_t=interpolation(X,Y,liste_t,t);
        X_res(i)=p_t(1);
        Y_res(i)=p_t(2);
        i=i+1;
    end 
    subplot(224);
    hold on;
    plot(X_res,Y_res);
    plot(X,Y,'r+')
    title 'Pas tchebychev'
    hold off;
end

