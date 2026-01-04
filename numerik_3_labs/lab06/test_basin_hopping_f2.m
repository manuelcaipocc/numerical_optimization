clear
close all
clc


% function handle
f2 = @(x) 1+(x(1).^2+x(2).^2)/4000-cos(x(1)).*cos(x(2)/sqrt(2));

% initial value
x0 = (2*rand(2,1)-1)*10;

% parameters for basin hopping
T = 1;
h_bas = 5;
num_it = 50;

% parameters for local optimizer (Hooke-Jeeves)
h_loc = [0.1;0.1];
tol = 10^(-8);

% function handle for local optimizer
loc_opt = @(x) hooke_jeeves(f2, x, h_loc, tol); 

% perform basin hopping
X = basin_hopping(f2, x0, T, loc_opt, h_bas, num_it);

% plot contour lines
figure('Position', [100,100,1000,700]);
[x,y] = meshgrid(min(X(1,:))-1:0.01:max(X(1,:))+1,min(X(2,:))-1:0.01:max(X(2,:))+1);
f = @(x,y) 1+(x.^2+y.^2)/4000-cos(x).*cos(y/sqrt(2));
z = f(x,y);
contour(x,y,z,'HandleVisibility','off');
shading interp;
colormap(turbo(256));
xlim([x(1),x(end)]);
ylim([y(1),y(end)]);
xlabel('x','interpreter','latex','FontSize', 14);
ylabel('y','interpreter','latex','FontSize', 14);
hold on;
plot(1000,1000,'x','Color',[0 0.5 0],'MarkerSize',10,'LineWidth',2);
plot(1000,1000,'xr','MarkerSize',10,'LineWidth',2);
legend('Exploration points $$x_{trial}$$','Local minima $$x_{loc}$$','interpreter','latex','Location','southeast','FontSize',14);

% plot iteration
dirX = X(1,2:end)-X(1,1:end-1);
dirY = X(2,2:end)-X(2,1:end-1);
L = sqrt(dirX.^2+dirY.^2);
dirX = dirX./L*0.7;
dirY = dirY./L*0.7;
for i = 1:size(X,2)-1
    if mod(i,2) == 0
        plot(X(1,i),X(2,i),'xr','MarkerSize',10,'LineWidth',2,'HandleVisibility','off');
    else
        plot(X(1,i),X(2,i),'x','Color',[0 0.5 0],'MarkerSize',10,'LineWidth',2,'HandleVisibility','off');
    end
    if i == 1
        pause(10);
    else
        pause(0.5);
    end
    plot(X(1,i:i+1),X(2,i:i+1),'b--','HandleVisibility','off');   
    quiver(X(1,i),X(2,i), dirX(i), dirY(i), 'MaxHeadSize',10, 'LineWidth',1,'Color','b','HandleVisibility','off');
end