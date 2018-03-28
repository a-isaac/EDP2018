function [] = stopFunction(ard)
    display('Disconnect Button Clicked...');
    global matrix;
    matrix.dummy(1,8) = 0;
    matrix.data = matrix.dummy; 

    fwrite(ard,'S');
    if (numel(timerfindall) ~= 0)
        stop(timerfindall); % Stop all timers
        delete(timerfindall); % Delete all timer objects
    end

    if (numel(instrfind) ~= 0) % Read all serial ports and returns as array
        delete(instrfind) % Delete serial objects
        instrreset; % And reset
    end
    fclose('all');
    display('Disconnect Successful!');
end

