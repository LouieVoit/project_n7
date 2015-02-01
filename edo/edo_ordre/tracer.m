function tracer( )
    
    %Schema Euler
    [T,Y]=ode_euler(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    figure;
    hold on;
    subplot(2,2,1);plot(T,Y(:,1),'b');
    title 'Schema Euler'
    xlabel 't'
    ylabel 'y1(t)'
    subplot(2,2,2);plot(T,Y(:,2),'r');
    xlabel 't'
    ylabel 'y2(t)'
    subplot(2,2,3);plot(Y(:,1),Y(:,2));
    xlabel 'y1(t)'
    ylabel 'y2(t)'
    hold off
    
     %Schema Heu25
    [T,Y]=ode_heun(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    figure;
    hold on;
    subplot(2,2,1);plot(T,Y(:,1),'b');
    title 'Schema Heun'
    xlabel 't'
    ylabel 'y1(t)'
    subplot(2,2,2);plot(T,Y(:,2),'r');
    xlabel 't'
    ylabel 'y2(t)'
    subplot(2,2,3);plot(Y(:,1),Y(:,2));
    xlabel 'y1(t)'
    ylabel 'y2(t)'
    hold off
    
     %Schema ru25ge
    [T,Y]=ode_runge(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    figure;
    hold on;
    subplot(2,2,1);plot(T,Y(:,1),'b');
    title 'Schema Runge'
    xlabel 't'
    ylabel 'y1(t)'
    subplot(2,2,2);plot(T,Y(:,2),'r');
    xlabel 't'
    ylabel 'y2(t)'
    subplot(2,2,3);plot(Y(:,1),Y(:,2));
    xlabel 'y1(t)'
    ylabel 'y2(t)'
    hold off
    
     %Schema rk41
    [T,Y]=ode_rk41(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    figure;
    hold on;
    subplot(2,2,1);plot(T,Y(:,1),'b');    
    title 'Schema rk41'
    xlabel 't'
    ylabel 'y1(t)'
    subplot(2,2,2);plot(T,Y(:,2),'r');
    xlabel 't'
    ylabel 'y2(t)'
    subplot(2,2,3);plot(Y(:,1),Y(:,2));
    xlabel 'y1(t)'
    ylabel 'y2(t)'
    hold off
    
     %Schema rk42
    [T,Y]=ode_rk42(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    figure;
    hold on;
    subplot(2,2,1);plot(T,Y(:,1),'b');
    title 'Schema rk42'
    xlabel 't'
    ylabel 'y1(t)'
    subplot(2,2,2);plot(T,Y(:,2),'r');
    xlabel 't'
    ylabel 'y2(t)'
    subplot(2,2,3);plot(Y(:,1),Y(:,2));
    xlabel 'y1(t)'
    ylabel 'y2(t)'
    hold off
    
    %Figure 2
    [Te,Ye]=ode_euler(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    [Th,Yh]=ode_heun(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    [Trunge,Yrunge]=ode_runge(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    [Trk41,Yrk41]=ode_rk41(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    [Trk42,Yrk42]=ode_rk42(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],25);
    [Tg,Yg]=ode_gauss(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],[25 15 1e-12]);

    figure;
    hold on;
    subplot(2,2,1);
    plot(Te,Ye(:,1),Te,Yh(:,1),Te,Yrunge(:,1),Te,Yrk41(:,1),Te,Yrk42(:,1),Te,Yg(:,1));
    legend 'Euler' 'Heun' 'Runge' 'rk41' 'rk42' 'Gauss'
    xlabel 't'
    ylabel 'y1(t)'
    subplot(2,2,2);
    plot(Te,Ye(:,2),Te,Yh(:,2),Te,Yrunge(:,2),Te,Yrk41(:,2),Te,Yrk42(:,2),Te,Yg(:,2));
    legend 'Euler' 'Heun' 'Runge' 'rk41' 'rk42' 'Gauss'
    xlabel 't'
    ylabel 'y2(t)'
    subplot(2,2,3);
    plot(Ye(:,1),Ye(:,2),Yh(:,1),Yh(:,2),Yrunge(:,1),Yrunge(:,2),Yrk41(:,1),Yrk41(:,2),Yrk42(:,1),Yrk42(:,2),Yg(:,1),Yg(:,2));
    legend 'Euler' 'Heun' 'Runge' 'rk41' 'rk42' 'Gauss'
    xlabel 'y1(t)'
    ylabel 'y2(t)'
    hold off
    
    %SchemaGauss
    [Tg1,Yg1]=ode_gauss(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],[25 2 1e-12]);
    [Tg2,Yg2]=ode_gauss(@phi,[0 6.6632868593231301896996820305], [ 2.00861986087484313650940188 0],[25 15 1e-6]);
    figure;
    hold on;
    subplot(2,2,1);
    plot(Tg,Yg(:,1),Tg,Yg1(:,1),Tg,Yg2(:,1));
    title 'Schema Gauss'
    legend 'iter=15 esp=1e-12' 'iter=2 esp=1e-12' 'iter=15 esp=1e-6'
    xlabel 't'
    ylabel 'y1(t)'
    subplot(2,2,2);
    plot(Tg,Yg(:,2),Tg1,Yg1(:,2),Tg2,Yg2(:,2));
    legend 'iter=15 esp=1e-12' 'iter=2 esp=1e-12' 'iter=15 esp=1e-6'
    xlabel 't'
    ylabel 'y2(t)'
    subplot(2,2,3);
    plot(Yg(:,1),Yg(:,2),Yg1(:,1),Yg1(:,2),Yg2(:,1),Yg2(:,2));
    legend 'iter=15 esp=1e-12' 'iter=2 esp=1e-12' 'iter=15 esp=1e-6'
    xlabel 'y1(t)'
    ylabel 'y2(t)'
    hold off
    
    
