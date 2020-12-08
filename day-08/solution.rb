require_relative 'boot_code'

boot_code = BootCode.new

boot_code.write_instructions

puts "First solution accumulator: #{boot_code.last_uniq_command}"

puts "Second solution accumulator: #{boot_code.fixed_program_accumulator}"
