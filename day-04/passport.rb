class Passport
  @passports = []

  def initialize
    passport_rows = File.readlines('./input.txt')
    @passports = normalize(passport_rows)
  end

  def write_passports
    @passports.each_with_index do |passport, i|
      p "passport #{i} #{passport}"
    end
  end

  def valid_count
    valid_counter = 0

    @passports.each do |passport|
      valid_counter += 1 unless invalid(passport)
    end

    valid_counter
  end

  private

  def normalize(raw_rows)
    passports = []
    passport = {}

    raw_rows.each_with_index do |row, i|
      row = row.gsub(/\R+/, '')

      if row.empty?
        passports << passport if !passport.empty?
        passport = {}
        next
      end

      raw_data = row.split(' ')
      raw_data.each do |data|
        key_value = data.split(':')
        passport[key_value[0]] = key_value[1]
      end
    end

    passports << passport if !passport.empty?

    passports
  end

  def invalid(passport)
    return true if passport.size < 7 || (passport.size == 7 && passport.has_key?("cid"))
    return true if invalid_year(passport["byr"], 1920, 2002)
    return true if invalid_year(passport["iyr"], 2010, 2020)
    return true if invalid_year(passport["eyr"], 2020, 2030)
    return true if invalid_height(passport["hgt"])
    return true if invalid_hair_color(passport["hcl"])
    return true if invalid_eye_color(passport["ecl"])
    return true if invalid_passport_id(passport["pid"])

    false
  end

  def invalid_year(year, least_yr, most_yr)
    !(year.length == 4 && year.to_i.between?(least_yr, most_yr))
  end

  def invalid_height(hgt)
    return true if hgt.length < 3

    uom = hgt.split(//).last(2).join
    return true if !['cm', 'in'].include?(uom)

    value = hgt[0,(hgt.length - 2)]
    return true if ! /\A\d+\z/.match?(value)

    return false if uom == 'cm' && value.to_i.between?(150, 193)
    return false if uom == 'in' && value.to_i.between?(59, 76)
    true
  end

  def invalid_eye_color(ecl)
    !"amb blu brn gry grn hzl oth".split(/\W+/).include?(ecl)
  end

  def invalid_hair_color(hcl)
    !(hcl.length == 7 && /\A#[0-9a-fA-F]+\z/.match?(hcl))
  end

  def invalid_passport_id(pid)
    !/\A\d{9}\z/.match?(pid)
  end
end