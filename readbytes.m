function readbytes(obj, event)
    global fig;
    global incoming_bytes;
    global incoming_index;
    global history;
    global history_index;
    global recieve_in_progress;
    global got_ack;
    global recieve_count;
    
    %new_byte = fread(obj, obj.BytesAvailable, 'uint8');
    new_byte = fread(obj, 1, 'uint8');
    
    % sprintf('Got byte: %s', char(new_byte(1)));
    
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
    
    if(recieve_in_progress && incoming_index >= 16)
        history(history_index, 1:18) = transpose(incoming_bytes);
        history_index = history_index + 1;
        recieve_in_progress = 0;
        
        recieve_count = recieve_count + 1;
        
        % Skriv ut datan vi fått
        % sprintf('Got some data: %s', num2str(incoming_bytes));
        
        
        %if(recieve_count >= 20)
            recieve_count = 1;
            
            %disp 'Updating GUI'
            % Hämta handles
            handles = guihandles(fig);
            
            % Uppdatera status bar
            set(handles.latest_bytes_text, 'String', num2str(incoming_bytes));

            % Uppdatera GUI
            set(handles.tejp_sensor_text, 'String', num2str(incoming_bytes(2)));
            set(handles.dist_front_sensor_text, 'String', num2str(incoming_bytes(3)));
            set(handles.dist_right_sensor_text, 'String', num2str(incoming_bytes(4)));
            set(handles.dist_left_sensor_text, 'String', num2str(incoming_bytes(5)));
            set(handles.rgb_sensor_text, 'String', num2str(incoming_bytes(6)));
            set(handles.gyro_sensor_text, 'String', num2str(incoming_bytes(7)));
            
            % Spara handles
            guidata(fig, handles);
        %end % if
    end % if
    
    % Nollställ inkommande kö, oavsett om vi fått startbit eller inte
    if(incoming_index >= 16)
        %disp 'Reseting'
        % Nollställ
        incoming_bytes = zeros(1,18);
        incoming_index = 1;
        recieve_in_progress = 0;
    end % if
end %  function