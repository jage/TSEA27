function senddirection
    global fig;
    global serialport;
    
    handles = guihandles(fig);
    
    data_to_send = zeros(1,4); 
   
    % Populera data_to_send
    data_to_send(1) = 'D';
    data_to_send(2) = str2double(get(handles.max_speed_edit, 'String'));
    data_to_send(3) = str2double(get(handles.direction_edit, 'String'));
    data_to_send(4) = 'B';
    
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

    disp(data_to_send);

end