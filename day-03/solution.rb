require_relative 'toboggan_route'

toboggan_route = TobogganRoute.new

toboggan_route.write_map_rows

puts "First tree count: #{toboggan_route.tree_count(3,1)}"

first = toboggan_route.tree_count(1,1)
second = toboggan_route.tree_count(3,1)
third = toboggan_route.tree_count(5,1)
fourth = toboggan_route.tree_count(7,1)
fifth = toboggan_route.tree_count(1,2)

puts "Second tree product: #{ first * second * third * fourth * fifth }"