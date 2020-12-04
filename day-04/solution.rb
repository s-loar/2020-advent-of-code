require_relative 'passport'

passport = Passport.new

# passport.write_passports

puts "Second Problem - valid passports: #{passport.valid_count}"