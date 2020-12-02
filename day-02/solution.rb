require_relative 'password_validator'

password_validator = PasswordValidator.new

puts "Count of valid passwords: #{password_validator.valid_count}"