% the data
     np=10000; % <- data/trace
% prepare the plot
     axes('xlim',[1,np],'ylim',[-2,3]);
     x=1:np;
     y=-inf*ones(size(x));
     lh=line(x,y,...
            'userdata',1,...
            'marker','.',...
            'markersize',5,...
            'linestyle','none');
     lb=line([inf,inf],[-2,3]);
     shg;
% % prepare a simple timer function
%      com=[
%           'ix=get(lh,''userdata'')+1;',...
%           'ix=rem(ix-1,np)+1;'...
%           'y(ix)=rand;'...
%           'set(lb,''xdata'',[ix,ix]);'...
%           'set(lh,''ydata'',y,''userdata'',ix);'
%      ];
% % create the timer
%      th=timer;
%      set(th,...
%         'timerfcn',com,...
%         'period',.05,...
%         'executionmode','fixedrate');
% % ...and start it
%      start(th);
% % use
% % stop(th);
% % delete(th);
ix = 1;

while(true)
    pause(0.05);
    ix = get(lh, 'userdata') + 1;
    ix = rem(ix - 1, np) + 1;
    y(ix) = rand;
    set(lb, 'xdata', [ix, ix]);
    set(lh, 'ydata', y, 'userdata', ix);
end % while