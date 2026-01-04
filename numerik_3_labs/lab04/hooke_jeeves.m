%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS:
% f: map from R^n to R
% x0: starting point, (n x 1)-dimensional 
% h0: starting step sizes, (n x 1)-dimensional 
% tol: tolerance >0
%
% VARIABLES:
% x: current iterate, (n x 1)-dimensional 
% X: matrix containing all iterates, (n x (number iteration steps + 1))-dimensional
% h: current step sizes, (n x 1)-dimensional 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[X] = hooke_jeeves(f, x0, h0, tol)

x = x0;
X = [x0];
h = h0;

% iterate until termination criterion met
while h>tol,
    disp(x);

    % perform exploration step
    y=explore(f,x,h)

    % if expl. step does not produce progress
    if all(x==y)
        
        % half step sizes and new expl. step
        h=h/2;

    % if expl. step does produce progress
    else
        
        % second exploration step 
        w=x+2*(y-x);
        z=explore(f,w,h);

        % if second expl. step better than first expl. step
        if f(z)<f(y)
            x=z;

        % if not
        else
            x=y;
        end

        X = [X,x];
       
    end

end

end

% exploration step in own function
function[x] = explore(f, x, h)

    n = length(x);
    
    % examine along coordinate axes of all n dimensions
    for j=1:n
        ej=zeros(n,1);
        ej(j)=1;
    
        % positive direction
        t_pos=x+h(j)*ej;
    
    
        %negative direction
        t_neg=x-h(j)*ej;
    
        %if decrease in positive direction
        if f(t_pos)<f(x)
            x=t_pos;
        
        % if no decrease in positive direction, but decrease in negative direction
        elseif f(t_neg)<f(x)
            x=t_neg;
        end
    end
end