% floory
global fig;

fig = openfig('frontend.fig');

% Initiera GUI
handles = guihandles(fig);
set(handles.connectbutton, 'Visible', 'on');
set(handles.disconnectbutton, 'Visible', 'off');
guidata(fig, handles);

% Initiera default-värden
global incoming_bytes;
global incoming_index;
global history;
global history_index;
global recieve_in_progress;
global got_ack;
global sending_config;
global recieve_count;

incoming_bytes = zeros(1,18);
incoming_index = 1;
recieve_count = 1;
sending_config = 0;
recieve_in_progress = 0;
got_ack = 1;

history = zeros(10000, 18);
history_index = 1;

% Fånga in tangenter
set(fig,'KeyPressFcn',@handle_keypress);
set(fig, 'KeyReleaseFcn', @handle_keyrelease);
