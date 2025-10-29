clear
close all
clc


% F and dF
F = @(x) [ 1-x(1); 10*(x(2)-x(1).^2); sqrt(x(1).^2+x(2).^2) ];
dF = @(x) [-1, 0; -20*x(1), 10; x(1)/sqrt(x(1).^2+x(2).^2), x(2)/sqrt(x(1).^2+x(2).^2)];

% two starting points
for x0 = [[-3;3], [2;4]]

    % apply Gauss-Newton method
    X_gn = gauss_newton(x0, F, dF, 10^(-10), 100);
    
    % apply Levenberg-Marquardt
    mu0 = 0.3;
    [X_lm, Mu_lm] = levenberg_marquardt(x0, F, dF, mu0, 0.3, 0.9, 10^(-10), 100);
    
    % compute values of Rosenbrock function
    [x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
    z =  sqrt( (1-x).^2 + (10*(y-x.^2)).^2 + x.^2+y.^2 );
    
    % set figure
    figure('Position', [100,100,1000,700]);
    sgtitle(['\underline{Rosenbrock function} with $$x_0=(',num2str(x0(1)),',',num2str(x0(2)),')$$'], 'Interpreter', 'latex', 'FontSize', 18);
    
    % 3D plot
    subplot(2,2,1);
    h = surf(x,y,z);
    h.FaceAlpha = 0.9;
    shading interp;
    colormap(turbo(256));
    hold on;
    plot3(X_gn(1,:),X_gn(2,:), sqrt( (1-X_gn(1,:)').^2 + (10*(X_gn(2,:)'-X_gn(1,:)'.^2)).^2 + X_gn(1,:)'.^2+X_gn(2,:)'.^2 ), '--.r', 'MarkerSize',15);
    plot3(X_lm(1,:),X_lm(2,:), sqrt( (1-X_lm(1,:)').^2 + (10*(X_lm(2,:)'-X_lm(1,:)'.^2)).^2 + X_lm(1,:)'.^2+X_lm(2,:)'.^2 ), '--.', 'Color', [0 0.6 0], 'MarkerSize',15);
    xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
    zlabel('$$r(x,y)=\left\|F(x,y)\right\|_2$$', 'Interpreter', 'latex', 'FontSize', 14);
    legend('','Gauss-Newton', 'Levenberg-Marquardt', 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 12);
    title('3D plot', 'Interpreter', 'latex', 'FontSize', 14);
    view(10,60);
    
    % contour lines plot
    subplot(2,2,2);
    contour(x,y,z,100,'HandleVisibility','off');
    hold on;
    plot(X_gn(1,:),X_gn(2,:),'--.r','MarkerSize',15);
    plot(X_lm(1,:),X_lm(2,:),'--.', 'Color', [0 0.5 0], 'MarkerSize',15);
    xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
    caxis([0,110]);
    colorbar();
    if x0(1) == 2
        rectangle('Position', [0.3,-0.5,0.8,1.5], 'EdgeColor','black', 'LineStyle',':','LineWidth',1.5);
    elseif x0(1) == -3
        rectangle('Position', [0.3,-0.58,0.77,1.63], 'EdgeColor','black', 'LineStyle',':','LineWidth',1.5);
    end
    plot(nan, nan, 'Color','black', 'LineStyle',':','LineWidth',1.5, 'DisplayName', 'zoom in');
    legend('Gauss-Newton', 'Levenberg-Marquardt', 'zoom in', 'Interpreter', 'latex', 'Location', 'northwest', 'FontSize', 12);
    title('Contour line plot', 'Interpreter', 'latex', 'FontSize', 14);
    
    % contour lines plot - zoom in
    subplot(2,2,3);
    if x0(1) == 2
        [x,y] = meshgrid(linspace(0.3,1,100), linspace(-0.5,0.9,100));
    elseif x0(1) == -3
        [x,y] = meshgrid(linspace(0.3,1.07,100), linspace(-0.55,1.05,100));
    end
    z =  sqrt( (1-x).^2 + (10*(y-x.^2)).^2 + x.^2+y.^2 );
    contour(x,y,z,100,'HandleVisibility','off');
    hold on;
    plot(X_gn(1,:),X_gn(2,:), '--.r', 'MarkerSize',15);
    plot(X_lm(1,:),X_lm(2,:), '--.', 'Color', [0 0.5 0], 'MarkerSize',15);
    if x0(1) == 2
        rectangle('Position', [0.38,0.11,0.09,0.11], 'EdgeColor','black', 'LineStyle',':','LineWidth',1.5);
        xlim([0.3,1]);
        ylim([-0.5,0.9]);
    elseif x0(1) == -3
        rectangle('Position', [0.39,0.11,0.07,0.09], 'EdgeColor','black', 'LineStyle',':','LineWidth',1.5);
        xlim([0.3,1.07]);
        ylim([-0.55,1.05]);
    end
    plot(nan, nan, 'Color','black', 'LineStyle',':','LineWidth',1.5);
    xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
    caxis([0,110]);
    colorbar();
    legend('Gauss-Newton', 'Levenberg-Marquardt', 'zoom zoom in', 'Interpreter', 'latex', 'Location', 'southwest', 'FontSize', 12);
    title('Contour line plot - zoom in', 'Interpreter', 'latex', 'FontSize', 14);
    
    % contour lines plot - zoom zoom in
    subplot(2,2,4);
    if x0(1) == 2
        [x,y] = meshgrid(linspace(0.4,0.45,100), linspace(0.13,0.2,100));
    elseif x0(1) == -3
        [x,y] = meshgrid(linspace(0.4,0.44,100), linspace(0.12,0.19,100));
    end
    z =  sqrt( (1-x).^2 + (10*(y-x.^2)).^2 + x.^2+y.^2 );
    contour(x,y,z,100,'HandleVisibility','off');
    hold on;
    plot(X_gn(1,:),X_gn(2,:), '--.r', 'MarkerSize',15);
    plot(X_lm(1,:),X_lm(2,:), '--.', 'Color', [0 0.5 0], 'MarkerSize',15);
    xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
    if x0(1) == 2
        xlim([0.4,0.45]);
        ylim([0.13,0.2]);
    elseif x0(1) == -3
        xlim([0.4,0.44]);
        ylim([0.12,0.19]);
    end
    caxis([0,110]);
    colorbar();
    legend('Gauss-Newton', 'Levenberg-Marquardt', 'Interpreter', 'latex', 'Location', 'southeast', 'FontSize', 12);
    title('Contour line plot - zoom zoom in', 'Interpreter', 'latex', 'FontSize', 14);

end