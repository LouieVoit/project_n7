%% recupere une liste de points cliqués sur la fenetre
function [X,Y] = saisi_points()
clear all; close all;
figure(1);
axis([0 1 0 1])
b=1;
X=[];
Y=[];
disp('taper RETURN apres le dernier point');
while ( b==1 )
[x,y,b]= ginput(1);
if (b==1)
    X=[X x];
    Y=[Y y];
    figure(1)
    hold on
    plot(x,y,'+'); %dessine les points un à un
    hold off
end
end;
hold on;
