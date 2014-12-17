function varargout = FinalGroup01(varargin)

%!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!
%!@!@!@!@!@! Keith Cochran !@!@!@!@!@!
%!@!@!@!@!@!@ Chris Fink !@!@!@!@!@!@!
%!@!@!@!@!@!@ Group 01 !@!@!@!@!@!@!@!
%!@!@!@!@!@!  ENGR 202-661 !@!@!@!@!@!
%!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalGroup01_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalGroup01_OutputFcn, ...
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



function FinalGroup01_OpeningFcn(hObject, eventdata, handles, varargin)

%Create an axis that spans the entire GUI and sets the desired background
%image. This is a non-plottable GUI and is only present for the sake of
%setting a background image.
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
bg = imread('bg.png'); imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
uistack(ah, 'bottom');

%Move GUI to center of the screen
movegui('center')

% Choose default command line output for FinalGroup01
handles.output = hObject;

%Initialization of variables
handles.gx = 0;
handles.gy = 0;
handles.gz = 0;
handles.gxFt = 0;
handles.gyFt = 0;
handles.gzFt = 0;
handles.rmLoop = 0;
handles.rmVec = 0;
handles.alphaCoe = .6;



%Below are the objects drawn to our axes along with other settings for said
%axes. This was placed in the opening function in order to draw a static
%image of our hgtransform object to the respective axes. This is outlined
%with lines that are comprised of asteriks.
%**************************************************************************
 %Finds axes with tag axes2 and draws the graph to that predefined spot
    %as defined in the figure in the GUI editor.
    axes(handles.directionAxis);
    
    %Set axis limits
    axis([-4 4 -4 4 0 50]);
    
    %Set the grid view to 3d, grid to on, etc.
    view(3);
    grid off;
    axis equal;
    hold on;
    axis off;
    view([0 0]);
    %Create an hgtransform object in a cylindrical type shape
    [x, y, z] = cylinder([2 2]);
    [rx, ry, rz] = sphere(20);
    h(1) = surface(x,y,4*z,'FaceColor','red');
    h(2) = surface(2*rx,2*ry,rz,'FaceColor','red');
    h(3) = surface(2*rx,2*ry,rz+4,'FaceColor','red');

    t = hgtransform('Parent', handles.directionAxis);
    set(h,'Parent',t)
    set(gcf, 'Renderer', 'opengl')
    
    %Use the object created above and set it to a static position
    trans = makehgtform('translate', [0, 0, 0]);
    set(t, 'Matrix', trans);

    drawnow
%**************************************************************************
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = FinalGroup01_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in dropOne.
function dropOne_Callback(hObject, eventdata, handles)

%Gets the value from the hardware configuartion drop down menu and stores
%it in the handles.hardwareConfig variable. This variable will be used in a
%later loop to select the proper run routine for the respective hardware
%configuration.
handles.hardwareConfig = get(handles.dropOne, 'Value');

%A simple if statement to turn the number one green (textOne) when 
%the drop down menu is accessed and a value is selected
  if handles.hardwareConfig>=0
      set(handles.textOne,'ForegroundColor','green', 'String', '1');
  end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function dropOne_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in dropTwo.
function dropTwo_Callback(hObject, eventdata, handles)

%Sets a variable for com port string formatting to COM##
comFormat=('COM%d');
%Attains the value from the user selection on the drop down menu
handles.comSelect = get(handles.dropTwo, 'Value');
%Sets the selected COM port with appropriate formatting to comPort handle
handles.comPort = sprintf(comFormat,handles.comSelect);
%A simple if statement to turn the number two green (textTwo) when 
%the drop down menu is accessed and a value is selected
  if handles.comSelect>=0
      set(handles.textTwo,'ForegroundColor','green', 'String', '2');
  end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dropTwo_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in serialButton.
function serialButton_Callback(hObject, eventdata, handles)

%First if loop check to see if the wired or wireless hardware configuration
%is selected. If the wired option is select from the drop down, it runs the
%setupSerial function.
if handles.hardwareConfig == 1
%Utilizes the given serial port setup code on button press and commits
%the variables accelerometer.s and serialFlag to the handles array.
    if (~exist('serialFlag','var'))
        [handles.accelerometer.s,handles.serialFlag]...
            = setupSerial(handles.comPort);
    %Sets the text color of the white 3 (textThree) to green to signify
    %that the serial serial setup has been successful
        set(handles.textThree,'ForegroundColor','green', 'String', '3');
    end
%Second criteria check for the if loop. In this scenario, if wireless is
%selected from the hardware configuration drop down, it then proceeds to
%run the setupSerialX which coincides with the XBee hardware.
elseif handles.hardwareConfig == 2
%Utilizes the given serial port setup code on button press and commits
%the variables accelerometer.s and serialFlag to the handles array.
    if (~exist('serialFlag','var'))
        [handles.accelerometer.s,handles.serialFlag]...
            = setupSerialX(handles.comPort);
    %Sets the text color of the white 3 (textThree) to green to signify
    %that the serial serial setup has been successful
        set(handles.textThree,'ForegroundColor','green', 'String', '3');
    end
end


% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in calibrateButton.
function calibrateButton_Callback(hObject, eventdata, handles)

%Utilizes the given accelerometer calibration function on button press
%and submits the variables accelerometer.s to the handle array
if(~exist('calCo', 'var'))
    handles.calCo = calibrate(handles.accelerometer.s);
%Changes the color of the white 4 (textFour) to green to signify that
%the accelerometer calibration has been successful.
    set(handles.textFour,'ForegroundColor','green', 'String', '4');
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in stopStart.
function stopStart_Callback(hObject, eventdata, handles)


%Gets the String from button stopStart and sets it to handles.str
%for later use in the stopStart button while loop.
handles.str = get(handles.stopStart,'String');

%If string equals to Start on press, change it to the color red
%and the string Stop. This also sets UserData to value 1 for use
%in stop/start while loop
if strcmp(handles.str, 'Start')
    set(handles.stopStart,'ForegroundColor','black', 'String',...
        'Stop', 'UserData', 1)
    set(handles.strikeText, 'String', '');
    
%Initialiaze variables rmLoop and rmVec on button press to reset the
%previous resultant vector value.
handles.rmLoop = 0;
handles.rmVec = 0;

% Update handles structure
guidata(hObject, handles);
     

%Checks if the value of the stopStart button (variable UserData)
%is 1 or 0. Proceeds depending on value.
while (get(handles.stopStart, 'UserData'))
       
    %Read accelerometer output
    [handles.gx, handles.gy, handles.gz] = ...
        readAcc(handles.accelerometer, handles.calCo);
    
    handles.gxFt = (1-handles.alphaCoe)*handles.gxFt...
        + handles.alphaCoe*handles.gx;
    handles.gyFt = (1-handles.alphaCoe)*handles.gyFt...
        + handles.alphaCoe*handles.gy;
    handles.gzFt = (1-handles.alphaCoe)*handles.gzFt...
        + handles.alphaCoe*handles.gz;
    
    %Calculate the resultant vector from the data
    handles.vecData = [handles.gxFt, handles.gyFt, handles.gzFt];
    handles.rmVec = norm(handles.vecData);
    
   
    
   %An if loop to attain the greatest resultant value while the 
   %while loop is running.     
 if handles.rmVec > handles.rmLoop
    handles.rmLoop = handles.rmVec;
 end
 
%Update handles structure
guidata(hObject, handles);

drawnow;
end

%Update handles structure
guidata(hObject, handles); 


%If the string doesn't equal to Start on button press, change
%the string text to Start. This also sets
%UserData to value 0 for use in stop/start while loop
else
    
    set(handles.stopStart,'String', 'Start', 'UserData', 0);
    
    %Set the value rmLoop to variable swingData
    handles.swingData = handles.rmLoop;
   
    %A comprehensive if/elseif loop with multiple thresholds. Once the
    %according threshold is reached, that portion of the if loop calls on
    %function animationStrike with input variables height, pTime and sound
    %file name. The height specifics how high the weight should go, and if
    %applicable play the respective wav file.
   if handles.swingData > 6
   animationStrike(42, .001, handles.directionAxis, 'boxing_bell.wav');
   set(handles.strikeText, 'String', 'STRIKE');
   elseif handles.swingData> 5.5
   animationStrike(37, .001, handles.directionAxis, 'mrt2.wav');
   elseif handles.swingData > 5
   animationStrike(33, .001, handles.directionAxis, 'mrt2.wav');
   elseif handles.swingData > 4.5
   animationStrike(29, .001, handles.directionAxis, 'empty.wav');
   elseif handles.swingData > 4
   animationStrike(25, .001, handles.directionAxis, 'empty.wav');
   elseif handles.swingData > 3.5
   animationStrike(21, .001, handles.directionAxis, 'empty.wav');
   elseif handles.swingData > 3
   animationStrike(17, .001, handles.directionAxis, 'mrt2.wav');
   elseif handles.swingData > 2.5
   animationStrike(13, .001, handles.directionAxis, 'empty.wav');
   elseif handles.swingData > 2
   animationStrike(9, .001, handles.directionAxis, 'empty.wav');
   elseif handles.swingData > 1.5
   animationStrike(5, .001, handles.directionAxis, 'mrt1.wav');
   elseif handles.swingData > 1
   animationStrike(1, .001, handles.directionAxis, 'empty.wav');
   end    
   
% Update handles structure
guidata(hObject, handles);
end




% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)

%Clear the workspace and command window
clc
clear all
%If the serial port array is empty, close the serial port
%and delete the serial port data
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
close all
disp('Serial Port Closed')

% --- Executes on selection change in diffPop.
function diffPop_Callback(hObject, eventdata, handles)
%A loop to set the value of alpha in respect to our filtering values. The
%filtering at default is 1, and can go as low as .5. Changing the filtering
%level will make our thresholds harder to reach. In turn making the game
%more difficult.
diffSelect = get(handles.diffPop, 'Value');
if diffSelect == 1
    handles.alphaCoe = .6;
elseif diffSelect == 2
    handles.alphaCoe = .59;
elseif diffSelect == 3
    handles.alphaCoe = .58;
end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function diffPop_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
        'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Update handles structure
guidata(hObject, handles);
