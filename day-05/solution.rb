require_relative 'boarding_pass'

boarding_pass = BoardingPass.new

boarding_pass.write_boarding_passes

puts "First Problem - the highest seat id is #{boarding_pass.highest_seat_id}"

puts "Second Problem - find your seat: #{boarding_pass.your_seat_id}"