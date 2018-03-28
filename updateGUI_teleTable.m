function [] = updateGUI_teleTable(handles,dataMatrix,pk)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%data = num2cell(dataMatrix(1:pk,1:8));


accelX = dataMatrix(end,3);
accelY = dataMatrix(end,4);
gyroY = dataMatrix(end,7);

set(handles.xAccel, 'String',num2str(accelX));
set(handles.yAccel, 'String',num2str(accelY));
set(handles.yGyro, 'String',num2str(gyroY));

drawnow;
end

