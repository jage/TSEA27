function sendconfig
    global fig;
    global serialport;
    
    handles = guihandles(fig);
    
    data_to_send = zeros(1,10); 
   
    % Populera data_to_send
    data_to_send(1) = 'S';
    data_to_send(2) = str2double(get(handles.p_line_edit, 'String'));
    data_to_send(3) = str2double(get(handles.d_line_edit, 'String'));
    data_to_send(4) = str2double(get(handles.p_wall_edit, 'String'));
    data_to_send(5) = str2double(get(handles.d_wall_edit, 'String'));
    data_to_send(6) = str2double(get(handles.tejp_edit, 'String'));
    data_to_send(7) = str2double(get(handles.max_speed_edit, 'String'));
    data_to_send(8) = str2double(get(handles.direction_edit, 'String'));
    data_to_send(9) = str2double(get(handles.min_speed_edit, 'String'));
    data_to_send(10) = 'B';
    
    disp('Start send');
    tic
    try
        i = 1;
        while i <= length(data_to_send)
            fwrite(serialport, data_to_send(i));
            i = i + 1;
        end % for
    catch SEND_ERROR
        fprintf('Send error: %s\n', SEND_ERROR.message);
    end % try
    disp(toc);

    handles = guihandles(fig);
    set(handles.status_text, 'String', sprintf('Skickade: %s', num2str(data_to_send)));
    guidata(fig, handles);
            
    disp(data_to_send);

end