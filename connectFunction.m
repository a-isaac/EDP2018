function [ard] = connectFunction(ard, handles)
    %   This file is called when the connect button is clicked on main GUI
    %   This file performs the following tasks:
    %   1. Open Serial port from comportport input variable
    %   2. Creates .CSV file and logs all recived telemetery into it at 1Hz
    %   3. Outputs csvfile log name for reference
    %   4. Also outputs timer object for reference

    GlobalDeclarations;
    initialization();
    display('Connecting...');
    cla(handles.Graph1, 'reset');
    try
        fopen(ard);
        display('Connection Successful!');

    catch 
        display('Failed to Open');
    end

end

