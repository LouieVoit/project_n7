% Control points selection for curve weight term in 
% Chan-Vese segmentation
%
% ml = select_control_points(I)
%
%   IN :  I data image
%   OUT : ml mask with ones on control points
%
% --------------------------------------------------
function ml = select_control_points(I)

    [X,Y] = ginput();
    X = floor(X)
    Y = floor(Y)
    [x,y,z] = size(I)
    ml = zeros(x,y);
    ml(Y,X) = 1;
    
end

