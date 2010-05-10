% Bluetooth

global history;
global history_index;
global serialport;
global connected;
global auto_update;
global recieve_in_progress;
global got_ack;
global sending_config;
global recieve_count;

recieve_count = 1;
sending_config = 0;
recieve_in_progress = 0;
got_ack = 1;
auto_update = 0;

history = zeros(64000, 18);
history_index = 1;

% Ta bort alla portar
delete(instrfind)

% Koppla upp mot seriellport
serialport = serial('COM6', 'BaudRate', 115200);
serialport.BytesAvailableFcnCount = 1;
serialport.BytesAvailableFcnMode = 'byte';
serialport.Timeout = 5;

% F�rs�k �ppna seriellport
try
    fopen(serialport);
catch
    sprintf('Connect error: %s', lasterr);
end

connected = 1;
% 
serialport.BytesAvailableFcn = @readbytes;
global incoming_bytes;
global incoming_index;
incoming_bytes = zeros(1,18);
incoming_index = 1;