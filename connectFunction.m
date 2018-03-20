function [ard] = connectFunction(ard, handles)
    %   This file is called when the connect button is clicked on main GUI
    %   This file performs the following tasks:
    %   1. Open Serial port from comportport input variable
    %   2. Creates .CSV file and logs all recived telemetery into it at 1Hz
    %   3. Outputs csvfile log name for reference
    %   4. Also outputs timer object for reference

    GlobalDeclarations;
    display('Connecting...');
    cla(handles.Graph1);

    try
        fopen(ard);
        fwrite(ard, 'G');
        error = false;
    catch 
        error = true;
    end
    
    if (error == false)
        fwrite(ard, 'G');
        %msgbox('Connection was successful!');
        delete(timerfindall);
        csvfile = 1;
        csvfilename = '';
        table_filename = '';
        timeLog = timer('TimerFcn',{@LTimer, ard, csvfile, csvfilename, handles,table_filename},... 
                                'ExecutionMode','fixedRate','Period', 0.15); 
        start(timeLog);
    end
end

