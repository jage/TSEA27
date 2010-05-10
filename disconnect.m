global serialport;

% Stäng
fclose(serialport)

% Ta bort alla öppna portar
delete(instrfind)

% Ta bort serialport
clear serialport