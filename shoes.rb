require 'drb'
require 'drb/observer'

URI="druby://127.0.0.1:8787"

Shoes.show_log
Shoes.app(:title => 'FLOOR-Y', :debug => true) do
  @threads = []
  class Robot
    attr_accessor :p_line, :d_line, :p_wall, :d_wall, :tejp_cal, :speed, :direction
    
    def initialize
      @p_line    = 0
      @d_line    = 0
      @p_wall    = 0
      @d_wall    = 0
      @tejp_cal  = 0
      @speed     = 200
      @direction = :stop
    end
    
    def direction_to_i
      case @direction
      when :stop         : 0
      when :forward      : 1
      when :backward     : 2
      when :right        : 3
      when :left         : 4
      when :rotate_right : 5
      when :rotate_left  : 6
      end
    end
    
    def to_a
      [@p_line, @d_line, @p_wall, @d_wall, @tejp_cal, @speed, direction_to_i].collect {|c| c.chr }
    end
  end
  
  @robot = Robot.new
    
  def log(text, prefix = "\n")
    @status.text = "#{prefix}#{text}" + @status.text
  end
  
  def send_command
    ascii_command = ["S"] + @robot.to_a + ["E", "B"]
    
    ascii_command.each do |c|
      @sp.write(c)
      @sp.flush
    end
      
    log("Sent #{@robot.direction}")
  end
  
  def get_status
    ascii_command = ["R"]
    
    ascii_command.each do |c|
      @sp.write(c)
      @sp.flush
    end
      
    log("Get status")
  end
  
  def forward
    @robot.direction = :forward
    send_command
  end
  
  def backward
    @robot.direction = :backward
    send_command
  end
  
  def left
    @robot.direction = :left
    send_command
  end
  
  def right
    @robot.direction = :right
    send_command
  end
  
  def stop
    @robot.direction = :stop
    send_command
  end
  
  def rotate_left
    @robot.direction = :rotate_left
    send_command
  end
  
  def rotate_right
    @robot.direction = :rotate_right
    send_command
  end
  
  @threads = []
  stack :margin => 20, :width => 500 do
    subtitle "FLOOR-Y"
    
    stack do
      flow do
        caption("P line")
        @p_line = edit_line("")
      end
      flow do
        caption("D line")
        @d_line = edit_line("")
      end
      flow do
        caption("P wall")
        @p_wall = edit_line("")
      end
      flow do
        caption("D wall")
        @d_wall = edit_line("")
      end
      flow do
        caption("Tejp cal")
        @tejp_cal = edit_line("")
      end
      flow do
        caption("Speed")
        @speed = edit_line(@robot.speed)
      end
      flow do
        caption("Direction")
        @direction = edit_line()
      end
    end    

    flow :width => 300 do
      stack :width => 100 do
        caption("COM")
      end
      
      stack :width => 200 do
        # @in_port  = edit_line("/dev/com4")
        @com_port = edit_line("/tmp/interceptty")
        @connect = button "Connect to device" do
          unless @sp                        
            log("Connecting to #{@com_port.text} ... ")
            
            # @connect.name = "Disconnect"
            if @sp = DRbObject.new(nil, URI)
              log("Connected")
            end
            
            @threads << Thread.new do
              while(c = @sp.getc) do
                log(c.chr, '')
              end
            end
            
            @threads << Thread.new do
              while(true) do
                sleep 1
                get_status
              end
            end
            
          else
            @sp.close
            log("Disconnected!")
          end
        end 
      end
                  
      @forward = button "Forward" do
        forward
      end
      
      @backward = button "Backward" do
        backward
      end
      
      @right = button "Right" do
        right
      end
      
      @left = button "Left" do
        left
      end
      
      @stop = button "Stop" do
        stop
      end
      
      @rotate_left = button "Rotate left" do
        rotate_left
      end
      
      @rotate_right = button "Rotate right" do
        rotate_right
      end
      
      @status = edit_box :width => 540
      
      @data_to_send = edit_box :width => 540, :height => 50
      @send_data = button "send" do
        @sp.write(@data_to_send.text.to_i.chr)
        @data_to_send.text = ""
      end
    end
        
    keypress do |k|
      case k
      when :up    : forward
      when :down  : backward
      when :right : right
      when :left  : left
      when :shift_down    : stop
      when :shift_right : rotate_right
      when :shift_left : rotate_left
      end
    end   
  end
end 
@threads.join
