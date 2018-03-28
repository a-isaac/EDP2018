function [] = LTimer(src, evt, ard, csvfile, csvfilename, handles,table_filename)
    if (ard.BytesAvailable <=0)
        display ('No new telemetry via bluetooth');
    else 
        StringFromSerial = fscanf(ard, '%s');
        %display(StringFromSerial);
        tele = strsplit(StringFromSerial, ',');
        %pk = str2num(tele{1});
        tableHandling(StringFromSerial, handles);
        Update_GUIgraph(handles)
        %fwrite(ard,150);
        toc
    end
               
end

