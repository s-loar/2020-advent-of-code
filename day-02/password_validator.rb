class PasswordValidator
  @passwords = []

  def initialize
    raw_passwords = File.readlines('./input.txt')
    @passwords = convert_passwords(raw_passwords)
  end

  def valid_position_count
    valid_counter = 0
    @passwords.each do |password|
      valid_counter += 1 if has_only_one_valid_position?(password)
    end
    valid_counter
  end

  def valid_count
    valid_counter = 0
    @passwords.each do |password|
      valid_counter += 1 if valid?(password)
    end
    valid_counter
  end

  def write_passwords
    @passwords.each do |password|
      p password
    end
  end

  private

  def has_only_one_valid_position?(password)
    letter_count = 0
    letter_count += 1 if password['password'][password['min'] - 1] == password['letter']
    letter_count += 1 if password['password'][password['max'] - 1] == password['letter']
    return true if letter_count == 1
    false
  end

  def valid?(password)
    letter_count = password['password'].count(password['letter'])
    return true if letter_count.between?(password['min'], password['max'])
    false
  end

  def convert_passwords(raw_passwords)
    password_construct = []

    raw_passwords.each do |raw_password|
      tmp_array = raw_password.split(' ')
      min_max = tmp_array[0].split('-')
      password_hash = {
        "min" => min_max[0].to_i,
        "max" => min_max[1].to_i,
        "letter" => tmp_array[1][0],
        "password" => tmp_array[2]
      }
      password_construct << password_hash
    end

    password_construct
  end
end