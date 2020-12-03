require_relative 'toboggan_route'

toboggan_route = TobogganRoute.new

# toboggan_route.write_map_rows

puts "First tree count: #{toboggan_route.tree_count(3,1)}"