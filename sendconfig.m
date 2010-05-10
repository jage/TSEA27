function sendconfig
    global fig;
    global serialport;
    global got_ack;
    global sending_config;
    sending_config = 1;
    retries = 0;
    
    handles = guihandles(fig);
    
    data_to_send = zeros(1,10); 
   
    % Populera data_to_send
    data_to_send(1) = 'S';
    data_to_send(2) = str2num(get(handles.p_line_edit, 'String'));
    data_to_send(3) = str2num(get(handles.d_line_edit, 'String'));
    data_to_send(4) = str2num(get(handles.p_wall_edit, 'String'));
    data_to_send(5) = str2num(get(handles.d_wall_edit, 'String'));
    data_to_send(6) = str2num(get(handles.tejp_edit, 'String'));
    data_to_send(7) = str2num(get(handles.max_speed_edit, 'String'));
    data_to_send(8) = str2num(get(handles.direction_edit, 'String'));
    data_to_send(9) = str2num(get(handles.min_speed_edit, 'String'));
    data_to_send(10) = 'B';
    
    i = 1;
    while i <= 10 && retries < 5
        try
            if got_ack || 1 < toc
                fwrite(serialport, data_to_send(i));
                got_ack = 0;
                i = i + 1;
                tic;
                retries = 0;
            end % if
        catch
            disp 'Could not write config byte'
            retries = retries + 1;
        end % try
        pause(0.001);
    end % for
    
    if retries < 5
        disp 'Sent byte train!'
    end % fi

    sending_config = 0;
end