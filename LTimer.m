function [] = LTimer(src, evt, ard, csvfile, csvfilename, handles,table_filename)
    global matrix;
    fwrite(ard,'G');
    if (ard.BytesAvailable <=0)
        display ('No new telemetry via bluetooth');
    else 
        StringFromSerial = fscanf(ard, '%s');
        tele = strsplit(StringFromSerial, ',');
        pk = str2num(tele{1});
        tableHandling(StringFromSerial, handles); 
    end
               
end

