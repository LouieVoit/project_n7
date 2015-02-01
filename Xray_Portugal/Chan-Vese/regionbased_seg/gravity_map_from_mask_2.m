% p = gravity_map_from_mask(m, a, f)
%
%   IN :  - m : the mask corresponding to gap shape
%         - a : fd(d(x,y)) = a*d(x,y)^2, with d the distance to the 
%               mask m is used to compute the gravity map
%         - f : (OPTIONAL) function handle R -> R to replace fd
%
%   OUT : - G : size(m) matrix, G(x,y) = gravity at x,y
%
% -----------------------------------------------------------------
function G = gravity_map_from_mask_2(m, a, varargin)

    % Check/get parameters
    in = inputParser;
    addOptional(in,'f',@(x) a*x.^4);
    addRequired(in,'m');
    addRequired(in,'a', @isnumeric);
    parse(in,m,a,varargin{:});
    
    f = in.Results.f;
    m = in.Results.m;
    a = in.Results.a;
    
    % Create the distance function to mask
    % d = 0 if (x,y) in mask
    D1 = bwdist(m);
    D2 = bwdist(1-m);

    % Compute the gravity field
    G = f(D1) - 2*f(D2);
    
    % ???
    G = double(G);

end

