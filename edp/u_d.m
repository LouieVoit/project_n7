function DirichletBoundaryValue = u_d(x)
%U_D   Data on the Dirichlet boundary
%   Y = U_D(X) returns function values at N discrete points  
%   on the Dirichlet boundary. This input data has to be choosen  
%   by the user. X has dimension N x 2 and Y has dimension N x 1.


%DirichletBoundaryValue =  ones(size(x,1),1);
DirichletBoundaryValue = zeros(size(x,1),1);
