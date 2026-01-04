%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS:
% f: objective function
% S: n-dim. polytope consisting of n+1 vertices; (n x (n+1))-dimensional
% tol: tolerance for termination 
% kmax: maximum number of iteration steps
% alpha: reflection coefficient
% beta: expansion coefficient
% gamma: contraction coefficient
% sigma: shrinkage coefficient
% p_plot, t_plot: for plotting, forget them
% 
% VARIABLES:
% S: n-dim. polytope consisting of n+1 vertices; (n x (n+1))-dimensional
% F: function evaluations at the vertices, (n+1)-dimensional
% k: number of iteration steps
% xc: barycenter of best n vertices
% xr: reflection point
% xe: extrapolation point
% xk: contraction point
% fc: function evaluation at barycenter
% fr: function evaluation at reflection point
% fe: function evaluation at extrapolation point
% fk: function evaluation at contraction point
% curr_ops: for plotting, forget it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function[] = nelder_mead(f, S, tol, kmax, alpha, beta, gamma, sigma, p_plot, t_plot)

n = size(S,2)-1;
k = 0;
curr_ops = {};

% evaluate f at vertices
F = zeros(1,n+1);
for j=1:n+1
    F(j) = f(S(:,j));
end

% sort vertices in ascending order of function value
[F,idx] = sort(F);
S = S(:,idx);

% compute barycenter of best n vertices
xc = mean(S(:,1:n),2);
fc = f(xc);

% termination criterion
while ( (1/(n+1))*sum( (F - f(xc)).^2 ) > tol ) && (k < kmax)

    % compute xr (reflection point)
    xr = xc + alpha*(xc - S(:,n+1));
    fr = f(xr);

    % first case: f1 <= fr <= fn
    if (F(1) <= fr) && (fr <= F(n))

        S(:,n+1) = xr;
        F(n+1)   = fr;
        curr_ops{end+1} = 'REFLECTION';

    % second case: fr < f1
    elseif fr < F(1)

        % compute xe (extrapolation point)
        xe = xc + beta*(xr - xc);
        fe = f(xe);

        % if extrapolation point better than reflection point
        if fe < fr
            S(:,n+1) = xe;
            F(n+1) = fe;
            curr_ops{end+1} = 'EXPANSION';
        else
            % new vertex = reflection point
            S(:,n+1) = xr;
            F(n+1) = fr;
            curr_ops{end+1} = 'REFLECTION';
        end

    % third case: fr > fn    
    elseif fr > F(n)

        % if fr not smaller than fn+1  (fr >= F(n+1))
        if fr >= F(n+1)

            % compute xk (contraction) wrt xn+1
            xk = xc + gamma*(S(:,n+1) - xc);
            fk = f(xk);

            % if fk smaller than fn+1
            if fk < F(n+1)
                S(:,n+1) = xk;
                F(n+1) = fk;
                curr_ops{end+1} = 'CONTRACTION';

            % if fk not smaller than fn+1 -> SHRINK
            else
                for j = 2:n+1
                    S(:,j) = S(:,1) + sigma*(S(:,j) - S(:,1));
                    F(j) = f(S(:,j));
                end
                curr_ops{end+1} = 'SHRINKING';
            end

        % if fr < fn+1
        elseif fr < F(n+1)

            % contraction wrt xr
            xk = xc + gamma*(xr - xc);
            fk = f(xk);

            if fk < fr
                S(:,n+1) = xk;
                F(n+1) = fk;
                curr_ops{end+1} = 'CONTRACTION';

            else
                % shrink
                for j = 2:n+1
                    S(:,j) = S(:,1) + sigma*(S(:,j) - S(:,1));
                    F(j) = f(S(:,j));
                end
                curr_ops{end+1} = 'SHRINKING';
            end

        end
    end

    % sort vertices again
    [F,idx] = sort(F);
    S = S(:,idx);

    % compute barycenter again
    xc = mean(S(:,1:n),2);

    % increase iteration step
    k = k + 1;

    % plotting (ignore)
    pause(1);
    set(p_plot, 'XData', [S(1,:),S(1,1)], 'YData', [S(2,:),S(2,1)]);
    if numel(curr_ops) > 4
        curr_ops(1) = [];
    end
    tmp = curr_ops{end};
    curr_ops{end} = ['\bf\underline{' curr_ops{end} '}'];
    set(t_plot, 'String', strjoin(curr_ops,', '));
    curr_ops{end} = tmp;

end

end