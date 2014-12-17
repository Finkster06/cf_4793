%Chris Fink - 08/23/14
%ECEC 304 - Final Project
%Temperature Warning System

%Creates a GUI that supports a temperature warning system that...
%communicates with Arduino across the serial

function varargout = FinalFig(varargin)
% FINALFIG MATLAB code for FinalFig.fig
%      FINALFIG, by itself, creates a new FINALFIG or raises the existing
%      singleton*.
%
%      H = FINALFIG returns the handle to a new FINALFIG or the handle to
%      the existing singleton*.
%
%      FINALFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALFIG.M with the given input arguments.
%
%      FINALFIG('Property','Value',...) creates a new FINALFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FinalFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop_btn.  All inputs are passed to FinalFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalFig

% Last Modified by GUIDE v2.5 25-Aug-2014 12:35:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalFig_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalFig_OutputFcn, ...
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


% --- Executes just before FinalFig is made visible.
function FinalFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FinalFig (see VARARGIN)

%Place images on GUI
ah = axes('unit', 'normalized', 'position', [0.01 0.9 0.1 0.1]); 
bg = imread('overclockingMeter.png'); imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
uistack(ah, 'top');

ah2 = axes('unit', 'normalized', 'position', [0.9 0.9 0.1 0.1]); 
bg2 = imread('Flame.png'); imagesc(bg2);
set(ah2,'handlevisibility','off','visible','off')
uistack(ah2, 'top');

%Move GUI to center of the screen
movegui('center')

% Choose default command line output for FinalFig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalFig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_btn.
function start_btn_Callback(hObject, eventdata, handles)
% hObject    handle to start_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% My Code Begins Here %%%
clc; %clear the screen

%clear the plot, in case anything remains from prev. run
cla(handles.TEMP_plot,'reset');

set(handles.temp_output,'String','Temperature Data') %clear the output text string
set(handles.temp_output,'String','Temperature (C): ')

%Make button red and have the words "running" show on the button
start_btn_data.color = get(handles.start_btn,'BackgroundColor'); %copy the initial color value
set(handles.start_btn,'UserData',start_btn_data); %store the color value before losing it
set(handles.start_btn,'BackgroundColor',[1 .5 .5]); %make the start_btn light red
set(handles.start_btn,'String','Running','Enable','off'); %make it change text to "Running", and disable the button
set(handles.serial_info,'String','Connecting to the Arduino');
drawnow; %force button state to visually update

%Sets a variable for com port string formatting to COM##
comFormat=('COM%d');
%Attains the value from the comport box
handles.comSelect = get(handles.com_port, 'Value');
%Sets the selected COM port with appropriate formatting to comPort handle
handles.comPort = sprintf(comFormat,handles.comSelect);
%Setup serial connection to Arduino
if(~exist('serialFlag', 'var'))
    [arduino.s,serialFlag] = serialSetup(handles.comPort);
end
%Read the set maxTemp from arduino and place it in GUI
maxTempr = maxTemp(arduino.s);
set(handles.temp_max,'String',maxTempr);
%Indicate Arduino-Matlab connection is established
set(handles.serial_info,'String','Connected...');
%Run file for temperature plot and real time data
startRun = 1;
tempGraph

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over start_btn.
function start_btn_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to start_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function temp_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function com_port_Callback(hObject, eventdata, handles)
% hObject    handle to com_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of com_port as text
%        str2double(get(hObject,'String')) returns contents of com_port as a double


% --- Executes during object creation, after setting all properties.
function com_port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to com_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in close_serial.
function close_serial_Callback(hObject, eventdata, handles)
% hObject    handle to close_serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Close Serial
closeSerial



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_value_Callback(hObject, eventdata, handles)
% hObject    handle to temp_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.temp_value,'String',tc);
% Hints: get(hObject,'String') returns contents of temp_value as text
%        str2double(get(hObject,'String')) returns contents of temp_value as a double


% --- Executes during object creation, after setting all properties.
function temp_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function temp_max_Callback(hObject, eventdata, handles)
% hObject    handle to temp_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_max as text
%        str2double(get(hObject,'String')) returns contents of temp_max as a double


% --- Executes during object creation, after setting all properties.
function temp_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
