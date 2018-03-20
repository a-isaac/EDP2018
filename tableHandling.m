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
    global matrix;
    tele = strsplit(packet, ',');
    pk = matrix.packet +1;
    %pk = str2num(tele{1});
    matrix.data(pk,1) = pk; 
    for i = 2:8
        matrix.data(pk,i) = str2num(tele{i});
    end
    updateGUI_teleTable(handles, matrix.data, pk);

end

