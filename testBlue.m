clear all;
clc;
ard = Bluetooth('CrowBTSlave',1);
fopen(ard);
fwrite(ard,'G');

for i=1:10
    tic
    StringFromSerial = fscanf(ard,'%s');
    tele = strsplit(StringFromSerial, ',');
    pk = str2num(tele{1});
    if (pk > 0)
        %fprintf('Packet #: %d\n',pk);
        fprintf('%s\n',StringFromSerial);
    else
        %display('No New Data in Port')
    end
    toc
end
%fprintf(ard,'S');
fclose(ard);
%fprintf(name)