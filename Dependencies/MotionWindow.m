function varargout = MotionWindow(varargin)
% MOTIONWINDOW MATLAB code for MotionWindow.fig
%      MOTIONWINDOW, by itself, creates a new MOTIONWINDOW or raises the existing
%      singleton*.
%
%      H = MOTIONWINDOW returns the handle to a new MOTIONWINDOW or the handle to
%      the existing singleton*.
%
%      MOTIONWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOTIONWINDOW.M with the given input arguments.
%
%      MOTIONWINDOW('Property','Value',...) creates a new MOTIONWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MotionWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MotionWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MotionWindow

% Last Modified by GUIDE v2.5 08-Apr-2018 03:08:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MotionWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @MotionWindow_OutputFcn, ...
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


% --- Executes just before MotionWindow is made visible.
function MotionWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MotionWindow (see VARARGIN)

% Choose default command line output for MotionWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MotionWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MotionWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Butt_stop.
function Butt_stop_Callback(hObject, eventdata, handles)
% hObject    handle to Butt_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Butt_stop



function Pos_String_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_String (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_String as text
%        str2double(get(hObject,'String')) returns contents of Pos_String as a double


% --- Executes during object creation, after setting all properties.
function Pos_String_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_String (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Action_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Action (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
