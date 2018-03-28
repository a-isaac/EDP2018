function [] = tableHandling(packet, handles)
    %{
    TELEMETRY
    ---------------
    1 - Packet
    2 - Time 
    3 - Accel X
    4 - Accel Y
    5 - Accel Z
    6 - Gyro X
    7 - Gyro Y
    8 - Gyro Z
    %}
    tele = strsplit(packet, ',');
    global matrix;
    pk = str2num(tele{1});
    

    if pk == 0
        pk = matrix.data(end,1);
        for i = 2:8
            matrix.data(pk+1,i) = packetLoss(matrix.data(pk-1,i), matrix.data(pk,i));
        end
        updateGUI_teleTable(handles, matrix.data, pk+1);
 
    else
        matrix.data(pk,1) = pk;

        for i = 2:8
            matrix.data(pk,i) = str2num(tele{i});
           
        end
        updateGUI_teleTable(handles, matrix.data, pk);
    end

end

