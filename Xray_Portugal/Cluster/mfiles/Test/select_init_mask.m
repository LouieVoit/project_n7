% Initialisation function for Chan-Vese segmentation
%
% m = select_init_mask(I)
%
%   IN :  I data image
%   OUT : m initial mask
%
% initialization is a rectangle selected by user.

function m = select_init_mask(I)

    rect = getrect();

    %-- Create initial mask
    m=zeros(size(I,1),size(I,2));
    xmin=floor(rect(1));
    ymin=floor(rect(2));
    xmax=floor(xmin+rect(3));
    ymax=floor(ymin+rect(4));
    m(ymin:ymax,xmin:xmax)=1;

end

