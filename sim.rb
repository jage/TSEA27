#!/opt/local/bin/ruby

while g = $stdin.getc.chr
  if g == "R"
    $stdout.write("S")
    $stdout.flush
    16.times.collect { rand(14) }.each do |c|
      $stdout.write(c.chr)
      $stdout.flush
    end
    $stdout.write("E")
    $stdout.flush
  end
end