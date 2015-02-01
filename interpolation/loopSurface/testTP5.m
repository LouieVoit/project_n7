load noeudsCube.mat
load facesCube.mat
disp('Subdivision du cube');
show(vertices',faces');
pause;
close;
[n,f]=subdivisionLoop(vertices',faces');
show(n,f);
pause;
close;
[n,f]=subdivisionLoop(n,f);
show(n,f);
pause;
close;
disp('Subdivision de la face humaine');
show(vertex0,face0);
pause;
close;
[n,f]=subdivisionLoop(vertex0,face0);
show(n,f);
pause;
close;
[n,f]=subdivisionLoop(n,f);
show(n,f);
pause;
close;