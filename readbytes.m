function readbytes(obj, event)
    global fig;
    global incoming_bytes;
    global incoming_index;
    global history;
    global history_index;
    global recieve_in_progress;
    global got_ack;
    
    %new_byte = fread(obj, obj.BytesAvailable, 'uint8');
    new_byte = fread(obj, 1, 'uint8');
        
    % Håller på och tar emot
    if(recieve_in_progress)
        %disp 'Got byte';
        incoming_bytes(incoming_index) = new_byte(1);
        incoming_index = incoming_index + 1;
    % Startbit
    elseif(char(new_byte(1)) == 'S')
        %disp 'Got a S'
        recieve_in_progress = 1;
        incoming_bytes(incoming_index) = new_byte(1);
        incoming_index = incoming_index + 1;
    % Ack
    elseif(char(new_byte(1)) == 'A')
        disp 'Got an A'
        got_ack = 1;
    else
        recieve_in_progress = 0;
    end % if
    
    if(incoming_index >= 16)
        if(recieve_in_progress)
            history(history_index, 1:18) = transpose(incoming_bytes);
            history_index = history_index + 1;
            recieve_in_progress = 0;

            % Hämta handles
            handles = guihandles(fig);

            % Uppdatera status bar
            set(handles.status_text, 'String', sprintf('Recieved: %s', num2str(incoming_bytes)));

            % Uppdatera GUI
            set(handles.tejp_sensor_text, 'String', num2str(incoming_bytes(2)));
            set(handles.dist_front_sensor_text, 'String', num2str(incoming_bytes(3)));
            set(handles.dist_right_sensor_text, 'String', num2str(incoming_bytes(4)));
            set(handles.dist_left_sensor_text, 'String', num2str(incoming_bytes(5)));
            set(handles.rgb_sensor_text, 'String', num2str(incoming_bytes(6)));
            set(handles.gyro_sensor_text, 'String', num2str(incoming_bytes(7)));

            % Spara handles
            guidata(fig, handles);
        end % if

        % Nollställ inkommande kö, oavsett om vi fått startbit eller inte
        incoming_bytes = zeros(1,18);
        incoming_index = 1;
        recieve_in_progress = 0;
    end % if
end %  function