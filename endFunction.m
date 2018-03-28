function [ output_args ] = endFunction( ard, handles )
    fwrite(ard,'S');
    display('Stop Button Clicked');
    global matrix;
     matrix.dummy(1,1:8) = 0;
     matrix.data = matrix.dummy; 
     cla(handles.Graph1, 'reset');
     cla(handles.Graph1);
     clearvars global matrix.data;
  
end

