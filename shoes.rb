require 'drb'
require 'drb/observer'

URI="druby://127.0.0.1:8787"

Shoes.show_log
Shoes.app(:title => 'FLOOR-Y', :debug => true) do
  
  # Represents the robot, has sensor values, sensor history and settings
  class Robot
    # Map a direction to a value
    DIRECTION_MAPPING = {
      :stop         => 0,
      :forward      => 1,
      :backward     => 2,
      :right        => 3,
      :left         => 4,
      :rotate_right => 5,
      :rotate_left  => 6
    }
    
    PARAMETER_ORDER = %w(
      tejp_sens 
      dist_front
      dist_right
      dist_left 
      rgb_color 
      gyro      
      p_line    
      d_line    
      p_wall    
      d_wall    
      tejp_cal  
      max_speed 
      speed     
      direction 
      start     
      min_speed
    ).collect {|s| s.to_sym }
        
    # Set the default values
    def initialize
      @sensors = {
        :tejp_sens  => 0,
        :dist_front => 0,
        :dist_right => 0,
        :dist_left  => 0,
        :rgb_color  => 0,
        :gyro       => 0
      }                 
                        
      @settings = {     
        :p_line    => 0,
        :d_line    => 0,
        :p_wall    => 0,
        :d_wall    => 0,
        :tejp_cal  => 0,
        :max_speed => 0,
        :speed     => 0,
        :direction => 0,
        :start     => 0,
        :min_speed => 0
      }
    end
        
    def sensor_keys
      PARAMETER_ORDER.select {|k| @sensors.include?(k) }
    end
    
    def setting_keys
      PARAMETER_ORDER.select {|k| @settings.include?(k) }
    end
        
    # Both sensor values and settings are packed in packages
    def package
      elements = @sensors.merge(@settings)
      PARAMETER_ORDER.collect {|k| elements[k.to_sym].to_i.chr }
    end
    
    # Set the direction, takes DIRECTION_MAPPING symbols
    def direction=(direction)
      @settings[:direction] = DIRECTION_MAPPING[direction]
    end
    
    def import(package)
      package.each_with_index do |value, i|
        self[PARAMETER_ORDER[i]] = value.to_i
      end
    end
    
    def []=(key, value)
      return @sensors[key]  = value if @sensors[key]
      return @settings[key] = value if @settings[key]
    end
    
    def [](key)
      @sensors.merge(@settings)[key]
    end
  end
    
  @robot = Robot.new
    
  def log(text, prefix = "\n")
    @status.text = "#{prefix}#{text}" + @status.text
  end
  
  def send_command
    ascii_command = ["S"] + @robot.package + ["E", "B"]
    
    log(ascii_command.join(""))
    
    ascii_command.each do |c|
      @sp.write(c)
      @sp.flush
    end
  end
  
  def get_status
    ascii_command = ["R"]
    
    ascii_command.each do |c|
      @sp.write(c)
      @sp.flush
    end
  end
  
  @threads = []
  @status_boxes = {}
  @settings_boxes = {}
  
  stack :margin => 20, :width => 500 do
    title "FLOOR-Y"
    
    flow :width => 400 do
      flow :width => 50 do
        para "Port"
      end
      
      flow :width => 110 do
        @com_port = edit_line("COM5", :width => 100)
      end
      
      flow :width => 150 do
        @connect = button "Connect" do
          unless @sp                        
            log("Connecting to #{@com_port.text} ... ")
            
            # @connect.name = "Disconnect"
            @sp = DRbObject.new(nil, URI)
            unless @sp.closed?
              log("Connected")
            end
                        
            @threads << Thread.new do
              incoming_bytes = []
              
              while(b = @sp.getc)
                incoming_bytes << b
                
                # Check for start byte
                if b.chr == 'S'
                  incoming_bytes = [b.chr]
                # Check for end byte
                elsif b.chr == 'E'                    
                  @robot.import(incoming_bytes[1..-2])
                  incoming_bytes = []
                end
              end
            end
                        
            animate(2) do
              @status_boxes.each do |key, box|
                box.text = @robot[key]
              end
            end            
          end
        end 
      end
    end
    
    stack :width => 400, :margin => 20 do
    end
    
    flow :width => 400 do
      # Sensors
      stack :width => 200 do
        caption "Sensors"
        @robot.sensor_keys.each do |key|
          flow :width => 200 do
            flow :width => 100 do
              para key
            end
            flow :width => 100 do
              @status_boxes[key] = para @robot[key]
            end   
          end
        end
        
        @enable_status_check = button "Enable status check" do
          @status_check_enabled = true

          @threads << Thread.new do
            while(@status_check_enabled) do
              sleep(0.5)
              get_status
            end
          end
        end
      end
      
      
      # Settings
      stack :width => 200 do
        caption "Settings"
        @robot.setting_keys.each do |key|
          flow :width => 300 do
            flow :width => 100 do
              para key
            end
            flow :width => 100 do
              @settings_boxes[key] = edit_line(@robot[key], :width => 50)
            end
          end
        end
        
        @send_settings = button "Send settings" do
          @settings_boxes.each_pair do |key, box|
            @robot[key] = box.text
          end
          send_command
          @send_settings.focus
        end
      end
    end
    
    stack :width => 400, :margin => 20 do
    end
    
    stack :width => 400 do
      @status = edit_box :width => 540
      
      @data_to_send = edit_box :width => 540, :height => 50
      @send_data = button "send" do
        @sp.write(@data_to_send.text.to_i.chr)
        @data_to_send.text = ""
      end
    end
        
    keypress do |k|
      d = case k
          when :up          : :forward
          when :down        : :backward
          when :right       : :right
          when :left        : :left
          when :shift_down  : :stop
          when :shift_right : :rotate_right
          when :shift_left  : :rotate_left
          end
      @robot.direction = d
      send_command
    end   
  end
  @threads.join
end 
