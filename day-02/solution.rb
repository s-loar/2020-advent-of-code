require_relative 'password_validator'

password_validator = PasswordValidator.new

password_validator.write_passwords

puts "Count of valid passwords (old way): #{password_validator.valid_count}"
puts "Count of valid passwords (new way): #{password_validator.valid_position_count}"