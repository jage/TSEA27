% Disconnect from bluetooth
function disconnect_from_bluetooth
    disp 'Trying to disconnect ...'
    
    global serialport;

    % Stäng
    fclose(serialport)

    % Ta bort alla öppna portar
    delete(instrfind)

    % Ta bort serialport
    clear serialport
    
    disp 'Disconnected'
end