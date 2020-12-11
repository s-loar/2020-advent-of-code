require_relative 'joltage_adapter'

joltage_adapter = JoltageAdapter.new

joltage_adapter.write_adapters

# puts "First solution: #{joltage_adapter.product_of_jolt_jumps}"

puts "Second solution: #{joltage_adapter.distinct_paths}"