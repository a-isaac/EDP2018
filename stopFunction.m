function [] = stopFunction(ard)
    display('Stop Button Clicked');
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
end

