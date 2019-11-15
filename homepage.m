function varargout = homepage(varargin)
% HOMEPAGE MATLAB code for homepage.fig
%      HOMEPAGE, by itself, creates a new HOMEPAGE or raises the existing
%      singleton*.
%
%      H = HOMEPAGE returns the handle to a new HOMEPAGE or the handle to
%      the existing singleton*.
%
%      HOMEPAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOMEPAGE.M with the given input arguments.
%
%      HOMEPAGE('Property','Value',...) creates a new HOMEPAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before homepage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to homepage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help homepage

% Last Modified by GUIDE v2.5 19-Mar-2018 19:52:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @homepage_OpeningFcn, ...
                   'gui_OutputFcn',  @homepage_OutputFcn, ...
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


% --- Executes just before homepage is made visible.
function homepage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to homepage (see VARARGIN)

% Choose default command line output for homepage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes homepage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = homepage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global selectedFeature;
global selectedInput;
global select;
global ch;
if ch == 1
    if strcmp(select,'faceDet') == 1
        if strcmp(selectedInput,'Image') == 1
            facedetection;
        else
            videoface;
        end
    elseif strcmp(select,'featDet') == 1
        if strcmp(selectedFeature,'Nose') == 1
            if strcmp(selectedInput,'Image') == 1
                nosedetection;
            else
                videonose;
            end
        elseif strcmp(selectedFeature,'Eyes') == 1
            if strcmp(selectedInput,'Image') == 1
               eyedetection;
            else
               videoeye;
            end
        elseif strcmp(selectedFeature,'Mouth') == 1
            if strcmp(selectedInput,'Image') == 1
                mouthdetection;
            else
               videomouth;
            end
        elseif strcmp(selectedFeature,'All') == 1
            if strcmp(selectedInput,'Image') == 1
                all;
            else
                frames;
            end
        end
    elseif strcmp(select,'faceRecog') == 1
        abc;
        flag = 0;
        retType = char(load('C:\Users\sudha\Documents\MATLAB\ret.txt'));
        if strcmp(retType,'notUnique') == 1
            errordlg('Input image must contain only 1 face','Input error');
            flag = 1;
        elseif strcmp(retType,'dbEmpty') == 1
             add = questdlg('Current database is empty. Would you like to add this image to the database?','Add image','Yes','No','Yes');
            if strcmp(add,'Yes') == 1
                dbstore;
            end
        flag = 1;
        end
        if flag == 0
            pause(2.5);
            choice = questdlg('Not matching with the query image?? Want to add the image to the database?','Add image','Yes','No','Yes');
            if strcmp(choice,'Yes') == 1
                dbstore;
            end   
        end
    elseif strcmp(select,'faceReg') == 1
        dbstore;
    end
elseif ch == 2
    if strcmp(select,'faceDet') == 1
        videoface;
    elseif strcmp(select,'featDet') == 1
        if strcmp(selectedFeature,'Nose') == 1
            videonose;
        elseif strcmp(selectedFeature,'Eyes') == 1
            videoeye;
        elseif strcmp(selectedFeature,'Mouth') == 1
            videomouth;
        elseif strcmp(selectedFeature,'All') == 1
            frames;
        end
    end
end

% --- Executes on button press in upload.
function upload_Callback(hObject, eventdata, handles)
% hObject    handle to upload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch;
global selectedInput;
global select;
strs2 = cellstr(get(handles.inputSelect,'string'));
selectedInput = strs2{get(handles.inputSelect,'value')};
if strcmp(selectedInput,'Image') == 1
    ch = 1;
else
    ch = 2;
end
if strcmp(select,'faceRecog') == 1 || strcmp(select,'faceReg') == 1
    ch = 1;
end
fileType = {'*.jpg;*.jpeg;*.png;*.tif';'*.mp4;*.mkv;*.3gpp;*.m4v;*.wmv'};
fileTypeIdentifier = {'img','img&video'};
[a,b] = uigetfile(fileType{ch},fileTypeIdentifier{ch});
loc = num2str(b);
name = num2str(a);

save('C:\Users\sudha\Documents\MATLAB\a.txt','loc','-ascii');
save('C:\Users\sudha\Documents\MATLAB\b.txt','name','-ascii');
if strcmp(select,'faceRecog') == 1 || strcmp(select,'faceReg') == 1
    inp = imread([b a]);
    imshow(inp,'Parent',handles.axes1);
else
    if strcmp(selectedInput,'Image') == 1
        inp = imread([b a]);
        imshow(inp,'Parent',handles.axes1);
    else 
        filename = fullfile(b,a);
        obj = VideoReader(filename);
        ax = handles.axes1;
        %while hasFrame(obj)
            vidFrame = readFrame(obj);
            image(vidFrame,'Parent',ax);
            set(ax,'Visible','off');
            %pause(1/obj.FrameRate);
        %end
        clear obj
    end
end
%msgbox('Ready to run!','Run','help');

% --- Executes on selection change in featureSelect.
function featureSelect_Callback(hObject, eventdata, handles)
% hObject    handle to featureSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global selectedFeature;
strs1 = cellstr(get(handles.featureSelect,'string'));
selectedFeature = strs1{get(handles.featureSelect,'value')};
global selectedInput;
strs2 = cellstr(get(handles.inputSelect,'string'));
selectedInput = strs2{get(handles.inputSelect,'value')};
set(handles.upload,'enable','on');
%if strcmp(selectedInput,'Image')==1
 %   msgbox('Upload image','Input','help');
%else
 %   msgbox('Upload video','Input','help');
%end
if strcmp(selectedFeature,'Nose') == 1
       set(handles.text1, 'String', 'Selected : Nose Detection');
   elseif strcmp(selectedFeature,'Eyes') == 1
       set(handles.text1, 'String', 'Selected : Eyes Detection');
    elseif strcmp(selectedFeature,'Mouth') == 1
        set(handles.text1, 'String', 'Selected : Mouth Detection');
    elseif strcmp(selectedFeature,'All') == 1
        set(handles.text1, 'String', 'Selected : All feature Detection');
end

% Hints: contents = cellstr(get(hObject,'String')) returns featureSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from featureSelect


% --- Executes during object creation, after setting all properties.
function featureSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to featureSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in faceRecog.
function faceRecog_Callback(hObject, eventdata, handles)
% hObject    handle to faceRecog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text1, 'String', 'Selected : Face Recognition');
global select;
select = 'faceRecog';
set(handles.upload,'enable','on');
%msgbox('Upload image','Input','help');

% --- Executes on button press in faceReg.
function faceReg_Callback(hObject, eventdata, handles)
% hObject    handle to faceReg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text1, 'String', 'Selected : Face Registration');
global select;
select = 'faceReg';
set(handles.upload,'enable','on');
%msgbox('Upload image','Input','help');

% --- Executes on button press in faceDetect.
function faceDetect_Callback(hObject, eventdata, handles)
% hObject    handle to faceDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text1, 'String', 'Selected : Face Detection');
global select;
global selectedInput;
select = 'faceDet';
%uiwait(msgbox('Select an input mode','Input','help'));
set(handles.inputSelect,'enable','on');

% --- Executes on button press in featureDetect.
function featureDetect_Callback(hObject, eventdata, handles)
% hObject    handle to featureDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global selectedInput;
global select;
select = 'featDet';
%uiwait(msgbox('Select an input mode','Input','help'));
set(handles.inputSelect,'enable','on');


% --- Executes on selection change in inputSelect.
function inputSelect_Callback(hObject, eventdata, handles)
% hObject    handle to inputSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns inputSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from inputSelect
global select;
global selectedInput;
if strcmp(select,'featDet') == 1
    %uiwait(msgbox('Select a feature from the drop-down menu','Feature','help'));
    set(handles.featureSelect,'enable','on');
elseif strcmp(select,'faceDet') == 1
    set(handles.upload,'enable','on');
end

% --- Executes during object creation, after setting all properties.
function inputSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.inputSelect,'enable','off');
set(handles.inputSelect,'Value',1);
set(handles.featureSelect,'enable','off');
set(handles.featureSelect,'Value',1);
set(handles.text1,'String','Selected : ');
set(handles.upload,'enable','off');
axes(handles.axes1);
hold off;
cla reset;
set(handles.axes1,'box','on');
set(handles.axes1,'xTick',[],'yTick',[]);