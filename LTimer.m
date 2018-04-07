function [] = LTimer(src, evt, ard, csvfile, csvfilename, handles,table_filename)
    if (ard.BytesAvailable <=0)
        display ('No new telemetry via bluetooth');
    else 
        StringFromSerial = fscanf(ard, '%s');
        %display(StringFromSerial);
        tele = strsplit(StringFromSerial, ',');
        %testpk = str2num(tele{1});
        display('table call')
        tableHandling(StringFromSerial, handles);
        global testpk
        testpk = testpk+1;
        testpk
        model(testpk);
        Update_GUIgraph(handles);
        %fwrite(ard,150);
        toc
    end
               
end

