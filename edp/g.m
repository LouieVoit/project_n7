function Stress = g(x);
%G  Stress force on the Neumann border.
%   Y = G(X) returns values of forces at N discrete points in the considered
%   domain. This input data has to be chosen by the user. X has dimension N
%   x 2 and Y has dimension N x 1.
%
%
Stress = zeros(size(x,1),1);
