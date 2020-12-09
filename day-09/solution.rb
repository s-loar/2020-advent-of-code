require_relative 'xmas'

xmas = Xmas.new

xmas.write_numbers

puts "First solution: #{xmas.no_sum_in_preambles(25)}"

puts "Second solution: #{xmas.sum_of_range_ends_summing_to(20874512)}"
