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
function G = gravity_map_from_mask(m, a, varargin)

    % Check/get parameters
    in = inputParser;
    addOptional(in,'f',@(x) a*x.^2);
    addRequired(in,'m', @isnumeric);
    addRequired(in,'a', @isnumeric);
    parse(in,m,a,varargin{:});
    
    f = in.Results.f;
    m = in.Results.m;
    a = in.Results.a;
    
    % Create the distance function to mask
    % d = 0 if (x,y) in mask
    D = bwdist(m);

    % Compute the gravity field
    G = f(D);
    
    % ???
    G = double(G);

end

