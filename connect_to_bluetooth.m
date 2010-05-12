% Connect through bluetooth
function connect_to_bluetooth
    global fig;
    global serialport;

    % Ta bort alla portar
    delete(instrfind)
    
    % Läs av vilken COM-port vi vill ansluta till
    handles = guihandles(fig);
    com_port = get(handles.com_port_edit, 'String');
    guidata(fig, handles);

    % Koppla upp mot seriellport
    serialport = serial(com_port, 'BaudRate', 115200);
    serialport.BytesAvailableFcnCount = 1;
    serialport.BytesAvailableFcnMode = 'byte';
    serialport.Timeout = 5;

    % Försök öppna seriellport
    try
        handles = guihandles(fig);
        set(handles.connectbutton, 'Visible', 'off');
        set(handles.disconnectbutton, 'Visible', 'on');
        set(handles.status_text, 'String', 'Connecting ...');
        guidata(fig, handles);
        
        % Wait for GUI to update before locking it
        pause(0.0001);
        
        fopen(serialport);
        
        % För varje byte som kommer, kör readbytes
        serialport.BytesAvailableFcn = @readbytes;
        
        handles = guihandles(fig);
        set(handles.status_text, 'String', 'Connected!');
        guidata(fig, handles);

    catch CONNECT_ERROR
        handles = guihandles(fig);
        set(handles.connectbutton, 'Visible', 'on');
        set(handles.disconnectbutton, 'Visible', 'off');
        set(handles.status_text, 'String', 'Connection error ...');
        guidata(fig, handles);

        fprintf('Connect error: %s\n', CONNECT_ERROR.message);
    end
end