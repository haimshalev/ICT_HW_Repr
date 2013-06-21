function varargout = ColorCorrectionForColorBlind(varargin)
% COLORCORRECTIONFORCOLORBLIND MATLAB code for ColorCorrectionForColorBlind.fig
%      COLORCORRECTIONFORCOLORBLIND, by itself, creates a new COLORCORRECTIONFORCOLORBLIND or raises the existing
%      singleton*.
%
%      H = COLORCORRECTIONFORCOLORBLIND returns the handle to a new COLORCORRECTIONFORCOLORBLIND or the handle to
%      the existing singleton*.
%
%      COLORCORRECTIONFORCOLORBLIND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLORCORRECTIONFORCOLORBLIND.M with the given input arguments.
%
%      COLORCORRECTIONFORCOLORBLIND('Property','Value',...) creates a new COLORCORRECTIONFORCOLORBLIND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ColorCorrectionForColorBlind_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ColorCorrectionForColorBlind_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ColorCorrectionForColorBlind

% Last Modified by GUIDE v2.5 19-Jun-2013 20:07:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ColorCorrectionForColorBlind_OpeningFcn, ...
                   'gui_OutputFcn',  @ColorCorrectionForColorBlind_OutputFcn, ...
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
addpath(genpath('Misc'));
AddMandatoryFolders();

% End initialization code - DO NOT EDIT

% --- Executes just before ColorCorrectionForColorBlind is made visible.
function ColorCorrectionForColorBlind_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ColorCorrectionForColorBlind (see VARARGIN)

% Choose default command line output for ColorCorrectionForColorBlind
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ColorCorrectionForColorBlind wait for user response (see UIRESUME)
% uiwait(handles.gui);

% --- Outputs from this function are returned to the command line.
function varargout = ColorCorrectionForColorBlind_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------

% --- Our Handlers

% --- open a bmp file
function openFile_ClickedCallback(hObject, eventdata, handles)
%Find Interactivly the path to the selected picture
[filename, pathname] = uigetfile( ...
{'*.bmp*',  'BMP File (*.bmp*)'}, ...
   'Pick a file you want to work with');

%if the user chose a file to work with 
if (filename ~= 0)
    %load the image to workspace variable
    image = imread(strcat(pathname,filename),'bmp');
    assignin('base', 'importedImg',image);
    
    %Show the selected image on figure 1
    axes(handles.figure_1()); % this is used to set focus on the axes
     %currently in use
    imshow(image);
    
    %reset figures
    axes(handles.figure_2());imshow(0);
    axes(handles.figure_3());imshow(0);
    axes(handles.figure_4());imshow(0);
    
    %Enable the run buttom 
    set(handles.button_run(),'Enable','on');
    
    disp(['--- Loaded: ' filename ' , with size ' int2str(size(image,1)) 'X' int2str(size(image,2))]);
end


% --- Executes when selected object is changed in panel_mode.
function panel_mode_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in panel_mode 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%Get all the controls
handles = guidata(hObject);

DichTypePanel = handles.rb_protanopes();
e = get(DichTypePanel,'Enable');

%in considerstion that we are starting from Simulate mode
if (strcmp(e,'on'))
    %Disable the Dichromats radio button panel and options
    otherRadio = handles.rb_protanopes();
    set(otherRadio, 'Enable', 'off');
    otherRadio = handles.rb_deuteranopes();
    set(otherRadio, 'Enable', 'off');
    otherRadio = handles.rb_tritanopic();
    set(otherRadio, 'Enable', 'off');
    
    %Change the figure labels accordingly
    set(handles.text_fig2(),'String','Protanopes Simulation');
    set(handles.text_fig3(),'String','Deuteranopes Simulation');
    set(handles.text_fig4(),'String','Tritanopic Simulation');
    
else
    %Enable the Dichromats radio button panel and options
    otherRadio = handles.rb_protanopes();
    set(otherRadio, 'Enable', 'on');
    otherRadio = handles.rb_deuteranopes();
    set(otherRadio, 'Enable', 'on');
    otherRadio = handles.rb_tritanopic();
    set(otherRadio, 'Enable', 'on');
    
    %Change the figure labels accordingly
    set(handles.text_fig2(),'String','Simulated Image');
    set(handles.text_fig3(),'String','Daltonized Image');
    set(handles.text_fig4(),'String','Daltonized Simulated Image');
    
end

%reset figures
axes(handles.figure_2());imshow(0);
axes(handles.figure_3());imshow(0);
axes(handles.figure_4());imshow(0);


% --- Executes on button press in button_run.
function button_run_Callback(hObject, eventdata, handles)
% hObject    handle to button_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Get the importe img variable 
image = evalin('base','importedImg');

clc;disp('- Procedure Started');tic

%reset figures
axes(handles.figure_2());imshow(0);
axes(handles.figure_3());imshow(0);
axes(handles.figure_4());imshow(0);

%Update the figures differntly in consideretion of the mode

%if we are in simulate mode
if (get(handles.rb_simulate,'Value') == 1)
    
    disp('-- Start Simulating what every color blind people see');
    
    %Show the selected image on figure 2
    axes(handles.figure_2());
    disp('--- Simulate what protanopes color blind people see');
    imshow(SimulateColorBlindImage( 1 , image ));

    %Show the selected image on figure 3
    axes(handles.figure_3());
    disp('--- Simulate what deuteranopes color blind people see');
    imshow(SimulateColorBlindImage( 2 , image ));

    %Show the selected image on figure 4
    axes(handles.figure_4());
    disp('--- Simulate what tritanopic color blind people see'); 
    imshow(SimulateColorBlindImage( 3 , image ));
  
%if we are in daltonize mode
else
        
    %Get the current dichromat type
    if (get(handles.rb_protanopes(),'Value'))
        typeName = 'protanopes';
        type = 1;
    elseif (get(handles.rb_deuteranopes(),'Value'))
        typeName = 'deuteranopes';
        type = 2;
    else 
        typeName = 'tritanopic';
        type = 3;
    end
    
    
    %Show the simulated image of figure 2
    disp(['--- Simulate what ' typeName ' color blind people see']);
    axes(handles.figure_2());
    imshow(SimulateColorBlindImage( type , image ));
    
    
    %Show the daltonized image on figure 3
    disp(['--- Daltonize image for ' typeName ' blind people']);
    axes(handles.figure_3());
    [ Ifinal , fileinfo , folderInfo ] = ColorBlindFix( type , image ); 
    imshow(Ifinal);

    %Show the daltonized and simulated image on figure 4
    disp(['--- Simulate what ' typeName ' color blind people see']); 
    axes(handles.figure_4());
    imshow(SimulateColorBlindImage( type , Ifinal ));
  
    
end

disp(['- Procedure Ended in ' num2str(toc) ' seconds']);

% --- Save the gui to bmp file
function saveFigure_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to saveFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Get from the user the output folder and prefix of files
[filename, pathname] = uiputfile({'*.bmp','bmp files'},'Save Images');

%if the user not canceled and choose a file name and path 
if (filename ~= 0)
    %Save the figures        
    warning ('off','all');
    export_fig([pathname '(Screenshot) ' filename], '-bmp',gcf);

if (get(handles.rb_simulate,'Value') == 1)
    export_fig([pathname '(Protanopes Simulated) ' filename], '-bmp',handles.figure_2());
    export_fig([pathname '(deuteranopes Simulated) ' filename], '-bmp',handles.figure_3());
    export_fig([pathname '(tritanopic Simulated) ' filename], '-bmp',handles.figure_4());
else
    export_fig([pathname '(Simulated) ' filename], '-bmp',handles.figure_2());
    export_fig([pathname '(Daltonized) ' filename], '-bmp',handles.figure_3());
    export_fig([pathname '(Daltonized Simulated) ' filename], '-bmp',handles.figure_4());
end
    warning ('on','all');
    disp(['--- Saved Snapshot to : ' pathname filename] );
end
