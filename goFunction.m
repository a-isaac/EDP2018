function [ output_args ] = goFunction( ard, handles )
    cla(handles.Graph1, 'reset');
    global matrix;
    matrix.dummy(1,1:8) =0;
    delete(timerfindall);
    csvfile = 1;
    csvfilename = '';
    table_filename = '';
    tic
    currentPath = get(handles.uibuttongroup1,'SelectedObject')
    % straight line
    if strcmp(currentPath.String,'Straight Path')
        fwrite(ard,'G');
    % circular path
    elseif strcmp(currentPath.String ,'Circle')
        fwrite(ard,'C');
    elseif strcmp(currentPath.String, 'Infinity')
        fwrite(ard,'I');
    end
    
    timeLog = timer('TimerFcn',{@LTimer, ard, csvfile, csvfilename, handles,table_filename},... 
                            'ExecutionMode','fixedRate','Period', 0.105); 
    start(timeLog);

end

