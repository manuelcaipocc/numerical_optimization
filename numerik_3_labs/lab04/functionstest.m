%% Visual examples of convexity (e)–(n)
clear; close all; clc;

x = linspace(-3,3,400);

figure('Name','Convexity examples','Color','w');
tiledlayout(2,5,'Padding','compact','TileSpacing','compact');

%% (e) Convex, but not strictly, with exactly one local minimum
% |x| is convex, not strict (linear segment at 0), and has a minimum at x = 0.
nexttile;
y = abs(x);
plot(x,y,'LineWidth',1.5); grid on;
title('(e) Convex, not strict, 1 minimum','FontWeight','bold');
xlabel('x'); ylabel('f(x)');
hold on;
plot(0,0,'ro','MarkerFaceColor','r');
text(0.2,0.5,'global minimum','Color','r');
text(-2,2.5,'Linear segment → not strict','FontSize',8);

%% (f) Convex, but not strictly, with NO local minimum
% f(x) = x is affine → convex, not strict, and has no minimum over R.
nexttile;
y = x;
plot(x,y,'LineWidth',1.5); grid on;
title('(f) Convex, not strict, no minimum','FontWeight','bold');
xlabel('x'); ylabel('f(x)');
text(-2.8,2.5,{'Affine function → convex','No lowest point'},'FontSize',8);

%% (g) Convex with more than one local minimum
% f(x) = max(0, |x|-1): convex with a flat region → infinitely many minima.
nexttile;
y = max(0,abs(x)-1);
plot(x,y,'LineWidth',1.5); hold on;
yline(0,'k:'); grid on;
title('(g) Convex with many minima','FontWeight','bold');
xlabel('x'); ylabel('f(x)');
fill([-1 1 1 -1],[0 0 0.2 0.2],[0.9 0.9 1],'EdgeColor','none');
text(-2.8,1.5,{'Flat zone [-1,1] →','infinitely many minima'},'FontSize',8);

%% (h) Attempt: convex with a local but not global minimum → impossible
nexttile; axis off;
text(0.5,0.7,{'(h) Impossible','In a convex function,','every local minimum','is also global'}, ...
    'HorizontalAlignment','center','FontSize',10);
text(0.5,0.35,{'If you draw a higher valley,','you lose convexity.'},...
    'HorizontalAlignment','center','FontSize',8);

%% (i) Attempt: convex with a local maximum → impossible
nexttile; axis off;
text(0.5,0.65,{'(i) Impossible','A convex function "curves upward"',...
    '→ cannot have an interior maximum'},...
    'HorizontalAlignment','center','FontSize',9);

%% (j) Attempt: convex with a saddle point → impossible in 1D
nexttile; axis off;
text(0.5,0.6,{'(j) Impossible in 1D','The derivative of a convex f','is monotonic ↑', ...
    '→ it cannot go up and down'},'HorizontalAlignment','center','FontSize',9);

%% (k) Attempt: convex function with a nonconvex solution set → impossible
nexttile; axis off;
text(0.5,0.65,{'(k) Impossible','The set of minima of a convex f',...
    'is always convex'},'HorizontalAlignment','center','FontSize',9);

%% (l) Strictly convex with exactly one minimum
% f(x) = x^2
nexttile;
y = x.^2;
plot(x,y,'LineWidth',1.5); grid on;
title('(l) Strictly convex, 1 minimum','FontWeight','bold');
xlabel('x'); ylabel('f(x)');
hold on;
plot(0,0,'ro','MarkerFaceColor','r');
text(0.2,1.5,'unique global minimum','Color','r');
text(-2,6,'Strict curvature → only one minimum','FontSize',8);

%% (m) Strictly convex with no local minimum
% f(x) = exp(x): strictly convex, but no minimum because it decreases without bound as x→−∞.
nexttile;
y = exp(x);
plot(x,y,'LineWidth',1.5); grid on;
title('(m) Strictly convex, no minimum','FontWeight','bold');
xlabel('x'); ylabel('f(x)');
text(-2.8,10,{'f(x)=e^x ↓ as x→−∞','→ does not reach a minimum'},'FontSize',8);

%% (n) Strictly convex with more than one minimum → impossible
nexttile; axis off;
text(0.5,0.65,{'(n) Impossible','If f is strictly convex,',...
    'it can have only one minimum.'},'HorizontalAlignment','center','FontSize',9);
text(0.5,0.35,{'Because: f(λx₁+(1−λ)x₂) < λf(x₁)+(1−λ)f(x₂)'},...
    'HorizontalAlignment','center','FontSize',8);

sgtitle('Convex vs. Strictly Convex — Visual Summary','FontWeight','bold','FontSize',12);
