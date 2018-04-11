function [] = Update_GUIgraph(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global matrix;

%     handles.Data = matrix.data;
% 
% %     if handles.Data(1,1) == 0
% %         handles.Data = matrix.dummy(1,1:8)
% %     end
%     
%         handles.Data;
%     xAxis = get(handles.graphxAxis, 'Value');
%     yAxis = get(handles.graphyAxis, 'Value');
% 
%     handles.xData = handles.Data(:,xAxis);
%     if yAxis == 1
%         yAxis = 3;
%     elseif yAxis == 2 
%         yAxis = 4;
%     else 
%         yAxis = 7;
%     end
%     handles.yData = handles.Data(:,yAxis);
%     cla(handles.Graph1);
%     grid(handles.Graph1, 'on');
% 
%     plot(handles.xData, handles.yData, '.-b', 'Parent', handles.Graph1);

global X_Est;
global testpk;
X_Est(testpk,1)
X_Est(testpk,2)
global X_MPC;
global array1;
global array2;

Path = [linspace(0,10,350)' linspace(0,10,350)'];
array1 = [array1 X_MPC(1,1)+(rand)*0.2];
array2 = [array2 X_MPC(2,1)];
handles.xData = array1;
handles.yData = array2;

handles.xData2 = Path(:,1);
handles.yData2 = Path(:,2);
axis equal

plot(handles.Graph1, handles.xData, handles.yData, '.-b', handles.xData2, handles.yData2, '.-r');
xlabel(handles.Graph1,'Relative X Position (m)');
ylabel(handles.Graph1,'Relative Y Position (m)');
legend(handles.Graph1,'Real Time', 'Reference');
title(handles.Graph1, 'Position Trajectory Reference vs Actual Trajectory'); 

end

