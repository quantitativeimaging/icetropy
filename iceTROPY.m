function varargout = iceTROPY(varargin)
% Matlab code for iceTROPY. Run to start GUI.
%    ICETROPY, by itself, creates a new ICETROPY or raises the existing
%    singleton*.
%
%    H = ICETROPY returns the handle to a new ICETROPY or the handle to
%    the existing singleton*.
%
%    ICETROPY('CALLBACK',hObject,eventData,handles,...) calls the local
%    function named CALLBACK in ICETROPY.M with the given input arguments
%
%    ICETROPY('Property','Value',...) creates a new ICETROPY or raises the
%    existing singleton*.  Starting from the left, property value pairs are
%    applied to the GUI before iceTROPY_OpeningFcn gets called.  An
%    unrecognized property name or invalid value makes property application
%    stop.  All inputs are passed to iceTROPY_OpeningFcn via varargin.
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iceTROPY

% Last Modified by GUIDE v2.5 11-Mar-2014 11:22:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iceTROPY_OpeningFcn, ...
                   'gui_OutputFcn',  @iceTROPY_OutputFcn, ...
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
end

% --- Executes just before iceTROPY is made visible.
function iceTROPY_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iceTROPY (see VARARGIN)

% Choose default command line output for iceTROPY
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes iceTROPY wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Initialise some tickbox flags, for vertical flips etc.
assignin('base','flagFlipudGf',0);
assignin('base','flagFlipudDat',0);
assignin('base','flagFlipudReg',0);
assignin('base','flagVideo',0);
assignin('base','flagShowVideo',0);
assignin('base','filterNumber',1);
assignin('base','cameraAreaSetup',1);
assignin('base','flagVidFramewise',0);
% TO DO: Move the following to check boxes once implemented
assignin('base','flagSubBuffer',0);


end

% --- Outputs from this function are returned to the command line.
function varargout = iceTROPY_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


%----------  START OF CALLBACK FUNCTIONS FOR BUTTONS  --------------%
function pathwayImDat_Callback(hObject, eventdata, handles)
% hObject    handle to pathwayImDat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathwayImDat as text
%        str2double(get(hObject,'String')) returns contents of pathwayImDat 
%        as a double
end

% --- Executes during object creation, after setting all properties.
function pathwayImDat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathwayImDat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
 end
end

% --- Executes on button press in browseData.
function browseData_Callback(hObject, eventdata, handles)
% hObject    handle to browseData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 tryPath = get(handles.pathwayImDat,'String'); 
 [FileNameDat,PathNameDat] = uigetfile({'*.tif'; '*.fits'}, ...
                              'Select data to process',tryPath);
 set(handles.pathwayImDat,'String',PathNameDat);
 set(handles.filenameImDat,'String',FileNameDat);
 guidata(hObject, handles);
end

% --- Executes on button press in flipudDat.
function flipudDat_Callback(hObject, eventdata, handles)
% hObject    handle to flipudDat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flipudDat

  assignin('base','flagFlipudDat', get(hObject,'Value') );
end

% --- Executes on button press in processButton.
function processButton_Callback(hObject, eventdata, handles)
% hObject    handle to processButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fullFileGf  = get(handles.pathwayGf,'String');
fullFileDat = fullfile( get(handles.pathwayImDat,'String'),...
                        get(handles.filenameImDat,'String'));

[flagImAnis,~,~ ]= iceTROPY_process( fullFileDat, fullFileGf );

end

% --- Executes on button press in videoTickbox.
function videoTickbox_Callback(hObject, eventdata, handles)
% hObject    handle to videoTickbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of videoTickbox

  assignin('base','flagVideo', get(hObject,'Value') );
end


function pathwayGf_Callback(~, eventdata, handles)
% hObject    handle to pathwayGf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathwayGf as text
%        str2double(get(hObject,'String')) returns contents of pathwayGf as a double
end

% --- Executes during object creation, after setting all properties.
function pathwayGf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathwayGf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
 end
end

% --- Executes on button press in browseGf.
function browseGf_Callback(hObject, eventdata, handles)
% hObject    handle to browseGf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 tryPath = get(handles.pathwayGf,'String'); 
 [FileNameGf,PathNameGf] = uigetfile({'*.tif'; '*.fits'}, ...
                              'Select g-factor calibration',tryPath);
 set(handles.pathwayGf,'String',fullfile(PathNameGf,FileNameGf));
 guidata(hObject, handles);
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in flipudGf.
function flipudGf_Callback(hObject, eventdata, handles)
% hObject    handle to flipudGf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flipudGf

  assignin('base','flagFlipudGf', get(hObject,'Value') );
end

% --- Executes on button press in browseReg.
function browseReg_Callback(hObject, eventdata, handles)
% hObject    handle to browseReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [FileNameReg,PathNameReg] = uigetfile({'*.tif'; '*.fits'});
 set(handles.pathwayImReg,'String',fullfile(PathNameReg,FileNameReg));
 guidata(hObject, handles);
end


function pathwayImReg_Callback(hObject, eventdata, handles)
% hObject    handle to pathwayImReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathwayImReg as text
%        str2double(get(hObject,'String')) returns contents of pathwayImReg as a double
end

% --- Executes during object creation, after setting all properties.
function pathwayImReg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathwayImReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
 end
end

% --- Executes on button press in registerButton.
function registerButton_Callback(hObject, eventdata, handles)
% hObject    handle to registerButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  fullFileReg = get(handles.pathwayImReg,'String');
  flagRegd = iceTROPY_registration( fullFileReg );
end

% --- Executes on button press in saveRegButton.
function saveRegButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveRegButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
  input_points = evalin('base','input_points');
  base_points  = evalin('base','base_points');
  mytform = evalin('base','mytform');
  edit1 = get(handles.pathwayGf,'String'); % Save text args for convenience
  edit2 = get(handles.pathwayImDat,'String');  
  edit3 = get(handles.filenameImDat,'String');
  edit4 = get(handles.pathwayImReg,'String');
  save('imageRegistration', 'input_points','base_points','mytform', ...
        'edit1','edit2','edit3','edit4');
  disp('Saved in working MATLAB folder as imageRegistration.mat');
end

% --- Executes on button press in loadRegButton.
function loadRegButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadRegButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  [filenameLoad,PathNameLoad]= uigetfile;
  load([PathNameLoad,filenameLoad]);   % Note doesn't load -> base W.space
  set(handles.pathwayGf,'String',edit1);
  % set(handles.pathwayImDat,'String',edit2);  % Don't change specimen
  % set(handles.filenameImDat,'String',edit3);
  set(handles.pathwayImReg,'String',edit4);
  assignin('base','input_points', input_points);
  assignin('base','base_points', base_points);
  assignin('base','mytform', mytform);
end


% --- Executes on selection change in filterMenu.
function filterMenu_Callback(hObject, eventdata, handles)
% hObject    handle to filterMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filterMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filterMenu
  
  assignin('base','filterNumber', get(hObject,'Value') );
end

% --- Executes during object creation, after setting all properties.
function filterMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
 end
end


% --- Executes on button press in flipudReg.
function flipudReg_Callback(hObject, eventdata, handles)
% hObject    handle to flipudReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flipudReg

  assignin('base','flagFlipudReg', get(hObject,'Value') );
end


function filenameImDat_Callback(hObject, eventdata, handles)
% hObject    handle to filenameImDat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filenameImDat as text
%        str2double(get(hObject,'String')) returns contents of filenameImDat as a double
end

% --- Executes during object creation, after setting all properties.
function filenameImDat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filenameImDat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), ...
                     get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end


% --- Executes on button press in showVideoTickbox.
function showVideoTickbox_Callback(hObject, eventdata, handles)
% hObject    handle to showVideoTickbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showVideoTickbox

  assignin('base','flagShowVideo', get(hObject,'Value') );
end

% --- Executes on selection change in cameraAreaSetupMenu.
function cameraAreaSetupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to cameraAreaSetupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cameraAreaSetupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cameraAreaSetupMenu

 assignin('base','cameraAreaSetup', get(hObject,'Value') );
end

% --- Executes during object creation, after setting all properties.
function cameraAreaSetupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraAreaSetupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function batchFilenameField_Callback(hObject, eventdata, handles)
% hObject    handle to batchFilenameField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of batchFilenameField as text
%        str2double(get(hObject,'String')) returns contents of batchFilenameField as a double

end

% --- Executes during object creation, after setting all properties.
function batchFilenameField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to batchFilenameField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

% --- Executes on button press in batchButton.
function batchButton_Callback(hObject, eventdata, handles)
% hObject    handle to batchButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 fullFileGf  = get(handles.pathwayGf,'String');
 pathDat = get(handles.pathwayImDat,'String');
 namePattern = get(handles.batchFilenameField,'String');
 
 flagImBatch = iceTROPY_batch( pathDat, fullFileGf, namePattern );
 
 assignin('base','listOfFiles',listOfFiles);
 assignin('base','listOfAnisotropies',listOfAnisotropies);
end


% --- Executes on button press in checkVidFramewise.
function checkVidFramewise_Callback(hObject, eventdata, handles)
% hObject    handle to checkVidFramewise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkVidFramewise
assignin( 'base','flagVidFramewise',get(hObject,'Value') );
end
