function varargout = frontend(varargin)
% FRONTEND M-file for frontend.fig
%      FRONTEND, by itself, creates a new FRONTEND or raises the existing
%      singleton*.
%
%      H = FRONTEND returns the handle to a new FRONTEND or the handle to
%      the existing singleton*.
%
%      FRONTEND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRONTEND.M with the given input arguments.
%
%      FRONTEND('Property','Value',...) creates a new FRONTEND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before frontend_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to frontend_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help frontend

% Last Modified by GUIDE v2.5 11-May-2010 19:48:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @frontend_OpeningFcn, ...
                   'gui_OutputFcn',  @frontend_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before frontend is made visible.
function frontend_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to frontend (see VARARGIN)

% Choose default command line output for frontend
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes frontend wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = frontend_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in connectbutton.
function connectbutton_Callback(hObject, eventdata, handles)
% hObject    handle to connectbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
connect_to_bluetooth

function sendconfigbutton_Callback(hObject, eventdata, handles)
sendconfig


% --- Executes on button press in disconnectbutton.
function disconnectbutton_Callback(hObject, eventdata, handles)
% hObject    handle to disconnectbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disconnect_from_bluetooth



function p_line_edit_Callback(hObject, eventdata, handles)
% hObject    handle to p_line_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB3
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p_line_edit as text
%        str2double(get(hObject,'String')) returns contents of p_line_edit as a double
handles.p_line_edit = get(hObject, 'String');

% --- Executes during object creation, after setting all properties.
function p_line_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_line_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_line_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d_line_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_line_edit as text
%        str2double(get(hObject,'String')) returns contents of d_line_edit as a double


% --- Executes during object creation, after setting all properties.
function d_line_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_line_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_wall_edit_Callback(hObject, eventdata, handles)
% hObject    handle to p_wall_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p_wall_edit as text
%        str2double(get(hObject,'String')) returns contents of p_wall_edit as a double



% --- Executes during object creation, after setting all properties.
function p_wall_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_wall_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_wall_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d_wall_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_wall_edit as text
%        str2double(get(hObject,'String')) returns contents of d_wall_edit as a double


% --- Executes during object creation, after setting all properties.
function d_wall_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_wall_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tejp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tejp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tejp_edit as text
%        str2double(get(hObject,'String')) returns contents of tejp_edit as a double


% --- Executes during object creation, after setting all properties.
function tejp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tejp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_speed_edit_Callback(hObject, eventdata, handles)
% hObject    handle to max_speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_speed_edit as text
%        str2double(get(hObject,'String')) returns contents of max_speed_edit as a double


% --- Executes during object creation, after setting all properties.
function max_speed_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function speed_edit_Callback(hObject, eventdata, handles)
% hObject    handle to speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speed_edit as text
%        str2double(get(hObject,'String')) returns contents of speed_edit as a double


% --- Executes during object creation, after setting all properties.
function speed_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function direction_edit_Callback(hObject, eventdata, handles)
% hObject    handle to direction_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of direction_edit as text
%        str2double(get(hObject,'String')) returns contents of direction_edit as a double


% --- Executes during object creation, after setting all properties.
function direction_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to direction_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function start_edit_Callback(hObject, eventdata, handles)
% hObject    handle to start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start_edit as text
%        str2double(get(hObject,'String')) returns contents of start_edit as a double


% --- Executes during object creation, after setting all properties.
function start_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_speed_edit_Callback(hObject, eventdata, handles)
% hObject    handle to min_speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_speed_edit as text
%        str2double(get(hObject,'String')) returns contents of min_speed_edit as a double


% --- Executes during object creation, after setting all properties.
function min_speed_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in autoupdate_box.
function autoupdate_box_Callback(hObject, eventdata, handles)
% hObject    handle to autoupdate_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autoupdate_box
%set(handles.autoupdate_box, 'Value', get(hObject, 'Value'));
%guidata(hObject, handles);
global auto_update;
auto_update = get(hObject, 'Value');


% --- Executes on button press in plot_button.
function plot_button_Callback(hObject, eventdata, handles)
% hObject    handle to plot_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotta


% --- Executes on button press in reset_history_button.
function reset_history_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_history_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global history;
global history_index;
history = zeros(size(history));
history_index = 1;


% --- Executes on button press in reload_button.
function reload_button_Callback(hObject, eventdata, handles)
% hObject    handle to reload_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rehash


% --- Executes on button press in reset_incoming_bytes_button.
function reset_incoming_bytes_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_incoming_bytes_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global incoming_bytes;
global incoming_index;
incoming_bytes = zeros(1,18);
incoming_index = 1;



function gyro_start_edit_Callback(hObject, eventdata, handles)
% hObject    handle to gyro_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gyro_start_edit as text
%        str2double(get(hObject,'String')) returns contents of gyro_start_edit as a double


% --- Executes during object creation, after setting all properties.
function gyro_start_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gyro_start_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_config_button.
function save_config_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_config_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load_config_button.
function load_config_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_config_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
