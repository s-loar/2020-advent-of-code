class Xmas
  @numbers = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @numbers = clean(raw_data)
  end

  def write_numbers
    @numbers.each_with_index do |number, i|
      puts "number #{i}: #{number}"
    end
  end

  def no_sum(preamble_length)
    @numbers_to_check = @numbers[preamble_length..-1]
    preamble_start = -1
    @numbers_to_check.each do |number|
      preamble_start += 1
      preamble_set = @numbers[preamble_start, preamble_length]
      return number if !sum_in_preambles?(number, preamble_set)
    end
    -1
  end

  private

  def sum_in_preambles?(number, preamble_set)
    puts "number #{number}"
    puts "preamble_set: #{preamble_set}"
    preamble_set.each do |x|
      preamble_set.each do |y|
        puts "Found a sum #{x} + #{y} = #{x + y}" if (x + y == number) && (x != y)
        return true if (x + y == number) && (x != y)
      end
    end
    puts "*** No sum found for #{number} ***"
    false
  end

  def clean(raw_data)
    clean_data = []
    raw_data.each do |row|
      clean_data << row.gsub(/\R+/, '').to_i
    end
    clean_data
  end
end