function casteljau_subdivision(ite)
figure;
[X,Y]=saisi_points;
plot(X,Y,'-+');
for i=1:ite
    [X,Y]=subdivision(X,Y);
    hold on;
    plot(X,Y,'-+');
    hold off;
      
end

