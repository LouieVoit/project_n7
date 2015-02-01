function VolumeForce = f(x);
%F   Volume force in considered domain.
%   Y = F(X) returns values of forces at N discrete points in the considered
%   domain. This input data has to be chosen by the user. X has dimension N
%   x 2 and Y has dimension N x 1.
%
%

%VolumeForce=2*pi^2*sin(pi*x(1))*sin(pi*x(2));
VolumeForce = 4*ones(size(x,1),1);
%VolumeForce = zeros(size(x,1),1);
