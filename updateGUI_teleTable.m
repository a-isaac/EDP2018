function [] = updateGUI_teleTable(handles,dataMatrix,pk)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%data = num2cell(dataMatrix(1:pk,1:8));
data = dataMatrix(1:pk,1:8);
set(handles.uitableTele, 'Data', data);
drawnow;
end

