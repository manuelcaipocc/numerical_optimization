function [x,lambda] = nullspace_method(A,a,B,b)
    n=size(A,1);
    m=size(B,1);

    %-- (1) QR-decomposition and splitting
    [Q, R]=qr(B');
    R = R(1:m,1:m);
    Y = Q(1:n,1:m);
    Z = Q(1:n,m+1:n);

    %-- (2) determine x_Y
    x_Y = (R')\b;

    %-- (3) determine x_Z and set x
    tildeB22 = Z'*A*Z;
    tildeb = (-1)*Z'*(a+A*Y*x_Y);
    x_Z    = tildeB22\tildeb;
    x      = Q*[x_Y' x_Z']';

    %-- (4) determine lambda
    tildeB11 = Y'*A*Y;
    tildeB12 = Y'*A*Z;
    h1       = (-1)*Y'*a;
    tildeg   = (h1 - tildeB11*x_Y - tildeB12*x_Z);    
    lambda   = R\tildeg;
end
