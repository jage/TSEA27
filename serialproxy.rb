require 'logger'
URI="druby://127.0.0.1:8787"

log_file = File.open('shoes.log', File::WRONLY | File::APPEND | File::CREAT)
log = Logger.new(log_file)
log.info("Forked")

require 'drb'
require 'drb/observer'
require 'rubygems'
log.info("Loaded rubygems")
require 'serialport'
log.info("Loaded gems")

$SAFE = 1 # disable eval() and friends

DRb.start_service(URI, SerialPort.new("/tmp/interceptty", 115200))

DRb.thread.join
