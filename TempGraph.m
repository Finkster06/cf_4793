%Create axes and surface for temperature plot and show it in Matlab GUI
if(~exist('myAxes','var'))
    
    buf_len = 500;
    index = 1:buf_len;
    zeroIndex = zeros(size(index));
    tcdata = zeroIndex;
    
    limits = [15 30];
    
    handles.TEMP_plot = axes('XLim',[0 buf_len],'YLim',[0 0.1],'ZLim',limits,'CLim',limits);
    view(0,0);
    grid on;
    
    s = surface(index,[0 0], [tcdata; zeroIndex],[tcdata; tcdata]);
   
    set(s,'EdgeColor','flat','FaceColor','flat','Parent',handles.TEMP_plot)
    colorbar
    
 
    drawnow;
guidata(hObject, handles);
end

%%
%Constant Real-Time temperature reading from Arduino
%Update color and temperature value on GUI
mode = 'T';
while(startRun == 1)
    
    tc = readTemp(arduino.s, mode);
    set(handles.temp_value,'String',tc);
    tcdata = [tcdata(2:end),tc];
    
    set(s,'Zdata',[tcdata;zeroIndex],'Cdata',[tcdata;tcdata])
    
    drawnow;
end

    
