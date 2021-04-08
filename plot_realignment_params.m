function plot_realignment_params(P)
% function plot_realignment_params(P)
% P   - realignment parameters textfile (rp_*.txt)
%       plot_realignment_params('rp_afMRI.txt')
%       OR
%       array of spm_vols (single session)
%       e.g. P = spm_select(Inf,'image','frames',[],[],[],inf)
%       plot_realignment_params((spm_vol(P)))
%       OR
%       cell structure of spm_vols (multiple sessions)
%       e.g. P{1} = spm_select(Inf,'image','frames',[],[],[],inf) 
%       e.g. P{2} = spm_select(Inf,'image','frames',[],[],[],inf) 
%       plot_realignment_params((spm_vol(P)))
%
%       if no parameter is provided it will ask for an rp*.txt file 

fg = spm_figure('Create','Realign');

if nargin<1
    P = spm_select(1,'mat','select rp_*.txt',[],[],'^rp');
end

if iscell(P) % can deal with multiple sessions or ...
    P = cat(1,P{:});
end

if size(P,1)<2 % single realignment textfile
    Params = load(P);
else
    Params = zeros(numel(P),12);
    for i=1:numel(P)
        Params(i,:) = spm_imatrix(P(i).mat/P(1).mat);
    end
end
%-Display results: translation and rotation over time series
%--------------------------------------------------------------------------
spm_figure('Clear','Graphics');
ax = axes('Position',[0.1 0.65 0.8 0.2],'Parent',fg,'Visible','off');
set(get(ax,'Title'),'String','Image realignment',...
    'FontSize',16,'FontWeight','Bold','Visible','on');
x     =  0.1;
y     =  0.9;

ax = axes('Position',[0.1 0.35 0.8 0.2],'Parent',fg,'XGrid','on','YGrid','on',...
    'NextPlot','replacechildren','ColorOrder',[0 0 1;0 0.5 0;1 0 0]);
plot(Params(:,1:3),'Parent',ax)
s  = {'x translation','y translation','z translation'};
%text([2 2 2], Params(2, 1:3), s, 'Fontsize',10,'Parent',ax)
legend(ax, s, 'Location','Best')
set(get(ax,'Title'),'String','translation','FontSize',16,'FontWeight','Bold');
set(get(ax,'Xlabel'),'String','image');
set(get(ax,'Ylabel'),'String','mm');


ax = axes('Position',[0.1 0.05 0.8 0.2],'Parent',fg,'XGrid','on','YGrid','on',...
    'NextPlot','replacechildren','ColorOrder',[0 0 1;0 0.5 0;1 0 0]);
plot(Params(:,4:6)*180/pi,'Parent',ax)
s  = {'pitch','roll','yaw'};
%text([2 2 2], Params(2, 4:6)*180/pi, s, 'Fontsize',10,'Parent',ax)
legend(ax, s, 'Location','Best')
set(get(ax,'Title'),'String','rotation','FontSize',16,'FontWeight','Bold');
set(get(ax,'Xlabel'),'String','image');
set(get(ax,'Ylabel'),'String','degrees'); 