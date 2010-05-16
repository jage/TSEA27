function close_realtime_plot(src, evt)
    global realtime_plot_enabled;
    realtime_plot_enabled = false;
    delete(gcf);
end % function
