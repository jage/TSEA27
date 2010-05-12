% Disconnect from bluetooth
function disconnect_from_bluetooth
    disp 'Trying to disconnect ...'
    global serialport;
    global fig;
    
    handles = guihandles(fig);
    set(handles.status_text, 'String', 'Trying to disconnect ...');
    guidata(fig, handles);
    
    % Wait for GUI to update
    pause(0.001);
    
    try
        try
            % Stäng
            fclose(serialport)
        catch
        end

        % Ta bort alla öppna portar
        delete(instrfind)

        % Ta bort serialport
        clear serialport
    catch DISCONNECT_ERROR
        fprintf('Connect error: %s\n', DISCONNECT_ERROR.message);
    end
    
    handles = guihandles(fig);
    set(handles.connectbutton, 'Visible', 'on');
    set(handles.disconnectbutton, 'Visible', 'off');
    set(handles.status_text, 'String', 'Disconnected!');
    guidata(fig, handles);
end