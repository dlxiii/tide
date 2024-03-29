function createfigure(X1, YMatrix1, station)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 13-May-2019 05:59:37

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1);
set(plot1(1),'DisplayName','gauge','MarkerFaceColor',[0 0 0],'MarkerSize',3,...
    'Marker','o',...
    'LineStyle','none');
set(plot1(2),'DisplayName','simulation','LineWidth',2);

% Create ylabel
ylabel({'Hight (m)'});

% Create xlabel
xlabel({'Time (JST)'});

% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[-1.5 1.5]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontName','Century Schoolbook L','FontSize',14,'XGrid','on',...
    'YGrid','on','YTickLabel',{'-2.0','-1.0','-0.5','0.0','0.5','1.0','2.0'});
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',14);

% Create title
title(['Time series tidal change (', station, ')']);

