function [] = Update_GUIgraph(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global matrix;

    handles.Data = matrix.data;

%     if handles.Data(1,1) == 0
%         handles.Data = matrix.dummy(1,1:8)
%     end
    
        handles.Data;
    xAxis = get(handles.graphxAxis, 'Value');
    yAxis = get(handles.graphyAxis, 'Value');

    handles.xData = handles.Data(:,xAxis);
    if yAxis == 1
        yAxis = 3;
    elseif yAxis == 2 
        yAxis = 4;
    else 
        yAxis = 7;
    end
    handles.yData = handles.Data(:,yAxis);
    cla(handles.Graph1);
    grid(handles.Graph1, 'on');

    plot(handles.xData, handles.yData, '.-b', 'Parent', handles.Graph1);
    


end

