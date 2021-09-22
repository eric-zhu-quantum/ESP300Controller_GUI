function varargout = ESPControllerGUI(varargin)
% ESPCONTROLLERGUI MATLAB code for ESPControllerGUI.fig
%      ESPCONTROLLERGUI, by itself, creates a new ESPCONTROLLERGUI or raises the existing
%      singleton*.
%
%      H = ESPCONTROLLERGUI returns the handle to a new ESPCONTROLLERGUI or the handle to
%      the existing singleton*.
%
%      ESPCONTROLLERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESPCONTROLLERGUI.M with the given input arguments.
%
%      ESPCONTROLLERGUI('Property','Value',...) creates a new ESPCONTROLLERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ESPControllerGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ESPControllerGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ESPControllerGUI

% Last Modified by GUIDE v2.5 07-Apr-2018 14:40:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ESPControllerGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ESPControllerGUI_OutputFcn, ...
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


% --- Executes just before ESPControllerGUI is made visible.
function ESPControllerGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ESPControllerGUI (see VARARGIN)

% Choose default command line output for ESPControllerGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ESPControllerGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
addpath(genpath([pwd, '\Dependencies']))

% --- Outputs from this function are returned to the command line.
function varargout = ESPControllerGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function PortCom_Callback(hObject, eventdata, handles)
% hObject    handle to PortCom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PortCom as text
%        str2double(get(hObject,'String')) returns contents of PortCom as a double


% --- Executes during object creation, after setting all properties.
function PortCom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PortCom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Butt_Connect.
function Butt_Connect_Callback(hObject, eventdata, handles)
% hObject    handle to Butt_Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.Text_Busy, 'String', 'Working!');
    GetPositions(handles)
    set(handles.Text_Busy, 'String', '');

%Function to get the positions of all 3 axes
%If there is no linear actuator connected to the axis, will display 0.0
function GetPositions(handles)
    ComPort = str2num(get(handles.PortCom, 'String'));
    Pos = [func_AxisPos_RS232(ComPort,1), func_AxisPos_RS232(ComPort, 2), func_AxisPos_RS232(ComPort, 3)];
    set(handles.Pos_x, 'String', sprintf('x = %2.3f',Pos(1)));
    set(handles.Pos_y, 'String', sprintf('y = %2.3f',Pos(2)));
    set(handles.Pos_z, 'String', sprintf('z = %2.3f',Pos(3)));



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Butt_Connect.
function Butt_Connect_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Butt_Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Menu_MoveAxis.
function Menu_MoveAxis_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_MoveAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Menu_MoveAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Menu_MoveAxis


% --- Executes during object creation, after setting all properties.
function Menu_MoveAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Menu_MoveAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_MoveTo_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_MoveTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_MoveTo as text
%        str2double(get(hObject,'String')) returns contents of Pos_MoveTo as a double


% --- Executes during object creation, after setting all properties.
function Pos_MoveTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_MoveTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Butt_GotoNewPos.
%Move axis (given in handles.Menu_MoveAxis) to the desired position,
% as given in handles.Pos_MoveTo
%real-time update of axis position given to handles.Pos_j
function Butt_GotoNewPos_Callback(hObject, eventdata, handles)
% hObject    handle to Butt_GotoNewPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ComPort = str2num(get(handles.PortCom, 'String'));
set(handles.Text_Busy, 'String', 'Working!');
    Axis = get(handles.Menu_MoveAxis, 'Value')-1;
    if (Axis == 0)
        set(handles.Text_Busy, 'String', '');
        return;
    end
    NewPos = str2double(get(handles.Pos_MoveTo, 'String'));
    if (NewPos>25) || (NewPos < (-25))
        set(handles.Text_Busy, 'String', '');
        return;
    end
    eval(sprintf('TextHandle = handles.Pos_%c', char('x'-1+Axis)));
    func_MoveAxis_RS232(ComPort, Axis, NewPos, TextHandle, handles.Butt_Stop);
%     instruction = sprintf('set(handles.Pos_%c, ''String'', [''%c = '',num2str(%f, ''%%02.3f'')])', char('x'-1+AxisNumber), char('x'-1+AxisNumber), NewPos);
%     eval(instruction);
set(handles.Text_Busy, 'String', '');



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Butt_GotoNewPos.
function Butt_GotoNewPos_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Butt_GotoNewPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Butt_JogRight.
function Butt_JogRight_Callback(hObject, eventdata, handles)
% hObject    handle to Butt_JogRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Jog(handles, +1);


% --- Executes on button press in Butt_JogLeft.
function Butt_JogLeft_Callback(hObject, eventdata, handles)
% hObject    handle to Butt_JogLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Jog(handles, -1);


%jog the axis (set by pull-down menu) in question by a certain amount
% as specified in handles.JogStepSize textbox
%gives real-time update of position in handles.Pos_j
function Jog(handles, Direction)
ComPort = str2num(get(handles.PortCom, 'String'));
set(handles.Text_Busy, 'String', 'Working!');
    Axis = (get(handles.Menu_JogAxis, 'Value')-1);
    if (Axis  == 0) 
        set(handles.Text_Busy, 'String', '');
        return;
    end    
    StepSize = abs(str2double(get(handles.JogStepSize, 'String')))    ;
    if (StepSize > 1)
        set(handles.Text_Busy, 'String', '');
        return;
    end
     eval(sprintf('TextHandle = handles.Pos_%c', char('x'-1+Axis)));
     StopHandle = handles.Butt_Stop;
     func_DeltaMoveAxis_RS232(ComPort, Axis, Direction*StepSize,1,TextHandle, StopHandle);
 set(handles.Text_Busy, 'String', '');

% --- Executes on selection change in Menu_JogAxis.
function Menu_JogAxis_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_JogAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Menu_JogAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Menu_JogAxis


% --- Executes during object creation, after setting all properties.
function Menu_JogAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Menu_JogAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Butt_JogLeft.
function Butt_JogLeft_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Butt_JogLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Butt_JogRight.
function Butt_JogRight_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Butt_JogRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text2.
function text2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function JogStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to JogStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of JogStepSize as text
%        str2double(get(hObject,'String')) returns contents of JogStepSize as a double


% --- Executes during object creation, after setting all properties.
function JogStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to JogStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Butt_Stop.
function Butt_Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Butt_Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Butt_Stop


% --- Executes on selection change in Menu_HomeAxis.
function Menu_HomeAxis_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_HomeAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Menu_HomeAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Menu_HomeAxis


% --- Executes during object creation, after setting all properties.
function Menu_HomeAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Menu_HomeAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Butt_Home.
function Butt_Home_Callback(hObject, eventdata, handles)
% hObject    handle to Butt_Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Home(handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Butt_Home.
function Butt_Home_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Butt_Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Home the axis
%real-time update of axis position given to handles.Pos_j
function Home(handles)
ComPort = str2num(get(handles.PortCom, 'String'));
set(handles.Text_Busy, 'String', 'Working!');
    Axis = (get(handles.Menu_HomeAxis, 'Value')-1);
    StopHandle = handles.Butt_Stop;
    if (Axis) == 0  % do nothing
        set(handles.Text_Busy, 'String', '');
        return;
    end
    eval(sprintf('TextHandle = handles.Pos_%c', char('x'-1+Axis)));
    func_HomeAxis_RS232(ComPort,Axis, TextHandle, StopHandle);
 set(handles.Text_Busy, 'String', '');
