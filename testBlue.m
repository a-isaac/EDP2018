clear all;
%as=instrhwinfo('Bluetooth');
%a=Bluetooth('CrowBTSlave', 0)
% fopen(a)
% data = fread(a,35)
% fclose(a)

ard = Bluetooth('CrowBTSlave',1);
fopen(ard);

% for i=1:10
% StringFromSerial = fscanf(ard,'%s');
% tele = strsplit(StringFromSerial, ',');
% pk = str2num(tele{1});
% fprintf('Packet #: %d\n',pk);
% fprintf('%s\n',StringFromSerial);
% end
% fclose(ard);

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
fclose(ard);
%fprintf(name)