function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 08-Feb-2018 17:17:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browseImage.
function browseImage_Callback(hObject, eventdata, handles)
% hObject    handle to browseImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global original_img;
[filename, pathname] = uigetfile({'*.*';},'File Selector');
img = imread([pathname filename]);
original_img = imread([pathname filename]);
axes(handles.axes2);
imshow(img);
%% 


% --- Executes on button press in grayscale.
function grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gray;
global img;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
gray = zeros(size(img,1), size(img,2), 'uint8');
for x=1:size(img,1)
    for y=1:size(img,2)
        rata = ((R(x,y)*0.3)+(G(x,y)*0.3)+(B(x,y)*0.4));
        gray(x,y) = rata;
    end
end
axes(handles.axes2);
imshow(gray);
        
        

% --- Executes on button press in zoomIn.
function zoomIn_Callback(hObject, eventdata, handles)
% hObject    handle to zoomIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global zoomIn;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
x = size(img,1)-200;
y = size(img,2)-200;
zoomIn = zeros(x, y, 'uint8');
for x=1:size(zoomIn,1)
    for y=1:size(zoomIn,2)
        zoomIn(x,y,1) = R(x+100,y+100);
        zoomIn(x,y,2) = G(x+100,y+100);
        zoomIn(x,y,3) = B(x+100,y+100);
    end
end
img = zoomIn;
axes(handles.axes2);
imshow(zoomIn);


% --- Executes on button press in zoomOut.
function zoomOut_Callback(hObject, eventdata, handles)
% hObject    handle to zoomOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global zoomOut;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
x = size(img,1)+200;
y = size(img,2)+200;
zoomOut = zeros(x, y, 'uint8');
for x=1:size(img,1)
    for y=1:size(img,2)
        zoomOut(x+100,y+100,1) = R(x,y);
        zoomOut(x+100,y+100,2) = G(x,y);
        zoomOut(x+100,y+100,3) = B(x,y);
    end
end
img = zoomOut;
axes(handles.axes2);
imshow(zoomOut);

% --- Executes on button press in invers.
function invers_Callback(hObject, eventdata, handles)
% hObject    handle to invers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global invers;
R = img(:, :, 1);
G = img(:, :, 2);
B = img(:, :, 3);
invers = zeros(size(img,1), size(img,2), 'uint8');
for x=1:size(img,1)
    for y=1:size(img,2)
        invers(x,y,1) = (255-R(x,y));
        invers(x,y,2) = (255-G(x,y));
        invers(x,y,3) = (255-B(x,y));
    end
end
img = invers;
axes(handles.axes2);
imshow(invers);



% --- Executes on button press in original.
function original_Callback(hObject, eventdata, handles)
% hObject    handle to original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
global original_img;
img = original_img;
axes(handles.axes2);
imshow(img);
