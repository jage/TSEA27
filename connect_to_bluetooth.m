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
        set(handles.status_text, 'String', 'Ansluter ...');
        guidata(fig, handles);
        
        % Vänta så att GUI:et hinner uppdatera sig, innan vi låser det
        pause(0.01);
        % Ansluter till porten
        fopen(serialport);
    catch CONNECT_ERROR
        handles = guihandles(fig);
        set(handles.status_text, 'String', 'Anslutningsfel, försöker igen ...');
        guidata(fig, handles);
        fprintf('Connect error: %s\n', CONNECT_ERROR.message);
        
        try
            pause(0.01);
            fopen(serialport);
        catch CONNECT_ERROR
            handles = guihandles(fig);
            set(handles.connectbutton, 'Visible', 'on');
            set(handles.disconnectbutton, 'Visible', 'off');
            set(handles.status_text, 'String', 'Anslutningsfel, ger upp!');
            guidata(fig, handles);
            fprintf('Connect error: %s\n', CONNECT_ERROR.message);
        end
    end
    
    % Om vi har anslutning
    if(strcmp(serialport.Status, 'open'))
        handles = guihandles(fig);
        set(handles.connectbutton, 'Visible', 'off');
        set(handles.disconnectbutton, 'Visible', 'on');
        set(handles.status_text, 'String', 'Ansluten!');
        guidata(fig, handles);
        
        % För varje byte som kommer, kör readbytes
        serialport.BytesAvailableFcn = @readbytes;
    end % if
end