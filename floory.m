% floory
global fig;

fig = openfig('frontend.fig');

% Initiera GUI
handles = guihandles(fig);
set(handles.connectbutton, 'Visible', 'on');
set(handles.disconnectbutton, 'Visible', 'off');
guidata(fig, handles);

