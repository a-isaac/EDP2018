function [ output_args ] = endFunction( ard, handles )
    fwrite(ard,'<0,0,0,0>');
    %fwrite(ard,'s');
    global testpk;
    testpk = 1;
    display('Stop Button Clicked');
    global matrix;
     matrix.dummy(1,1:8) = 0;
     %matrix.data(:,:) = matrix.dummy(1,end);
%     matrix.data = matrix.dummy;
    clear global matrix;
     
%      cla(handles.Graph1, 'reset');
%      cla(handles.Graph1);
     %clearvars global matrix.data;

end

