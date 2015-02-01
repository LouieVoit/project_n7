function tracer( )
    figure;
    hold on
    %%
    [T,Yre]=ode_euler(@phi1,[0 1.5],10,30);
    [T,Yh]=ode_heun(@phi1,[0 1.5],10,30);
    [T,Yrunge]=ode_runge(@phi1,[0 1.5],10,30);
    [T,Yrk41]=ode_rk41(@phi1,[0 1.5],10,30);
    [T,Yrk42]=ode_rk42(@phi1,[0 1.5],10,30);
    [T,Ygauss]=ode_gauss(@phi1,[0 1.5],10,[30 40 1e-6]);
    subplot(221);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    title 'IVP1'
    
    %%
    [T,Yre]=ode_euler(@phi1,[0 1.5],10,40);
    [T,Yh]=ode_heun(@phi1,[0 1.5],10,40);
    [T,Yrunge]=ode_runge(@phi1,[0 1.5],10,40);
    [T,Yrk41]=ode_rk41(@phi1,[0 1.5],10,40);
    [T,Yrk42]=ode_rk42(@phi1,[0 1.5],10,40);
    [T,Ygauss]=ode_gauss(@phi1,[0 1.5],10,[40 40 1e-6]);
    subplot(222);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    %%
    [T,Yre]=ode_euler(@phi1,[0 1.5],10,80);
    [T,Yh]=ode_heun(@phi1,[0 1.5],10,80);
    [T,Yrunge]=ode_runge(@phi1,[0 1.5],10,80);
    [T,Yrk41]=ode_rk41(@phi1,[0 1.5],10,80);
    [T,Yrk42]=ode_rk42(@phi1,[0 1.5],10,80);
    [T,Ygauss]=ode_gauss(@phi1,[0 1.5],10,[80 40 1e-6]);
    subplot(223);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    %%
    [T,Yre]=ode_euler(@phi1,[0 1.5],10,100);
    [T,Yh]=ode_heun(@phi1,[0 1.5],10,100);
    [T,Yrunge]=ode_runge(@phi1,[0 1.5],10,100);
    [T,Yrk41]=ode_rk41(@phi1,[0 1.5],10,100);
    [T,Yrk42]=ode_rk42(@phi1,[0 1.5],10,100);
    [T,Ygauss]=ode_gauss(@phi1,[0 1.5],10,[100 40 1e-6]);
    subplot(224);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    legend 'Euler' 'Heun' 'Runge' 'rk41' 'rk42' 'Gauss'
    hold off;
    figure;
    hold on
    %%
    [T,Yre]=ode_euler(@phi2,[0 1.5],0,30);
    [T,Yh]=ode_heun(@phi2,[0 1.5],0,30);
    [T,Yrunge]=ode_runge(@phi2,[0 1.5],0,30);
    [T,Yrk41]=ode_rk41(@phi2,[0 1.5],0,30);
    [T,Yrk42]=ode_rk42(@phi2,[0 1.5],0,30);
    [T,Ygauss]=ode_gauss(@phi2,[0 1.5],0,[30 40 1e-6]);
    subplot(221);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    title 'IVP2'
    
    %%
    [T,Yre]=ode_euler(@phi2,[0 1.5],0,40);
    [T,Yh]=ode_heun(@phi2,[0 1.5],0,40);
    [T,Yrunge]=ode_runge(@phi2,[0 1.5],0,40);
    [T,Yrk41]=ode_rk41(@phi2,[0 1.5],0,40);
    [T,Yrk42]=ode_rk42(@phi2,[0 1.5],0,40);
    [T,Ygauss]=ode_gauss(@phi2,[0 1.5],0,[40 40 1e-6]);
    subplot(222);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    %%
    [T,Yre]=ode_euler(@phi2,[0 1.5],0,80);
    [T,Yh]=ode_heun(@phi2,[0 1.5],0,80);
    [T,Yrunge]=ode_runge(@phi2,[0 1.5],0,80);
    [T,Yrk41]=ode_rk41(@phi2,[0 1.5],0,80);
    [T,Yrk42]=ode_rk42(@phi2,[0 1.5],0,80);
    [T,Ygauss]=ode_gauss(@phi2,[0 1.5],0,[80 40 1e-6]);
    subplot(223);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    %%
    [T,Yre]=ode_euler(@phi2,[0 1.5],0,100);
    [T,Yh]=ode_heun(@phi2,[0 1.5],0,100);
    [T,Yrunge]=ode_runge(@phi2,[0 1.5],0,100);
    [T,Yrk41]=ode_rk41(@phi2,[0 1.5],0,100);
    [T,Yrk42]=ode_rk42(@phi2,[0 1.5],0,100);
    [T,Ygauss]=ode_gauss(@phi2,[0 1.5],0,[100 40 1e-6]);
    subplot(224);plot(T,Yre,T,Yh,T,Yrunge,T,Yrk41,T,Yrk42,T,Ygauss);
    legend 'Euler' 'Heun' 'Runge' 'rk41' 'rk42' 'Gauss'
    hold off;
end

