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

  def no_sum_in_preambles(preamble_length)
    @numbers_to_check = @numbers[preamble_length..-1]
    preamble_start = -1
    @numbers_to_check.each do |number|
      preamble_start += 1
      preamble_set = @numbers[preamble_start, preamble_length]
      return number if !sum_in_preambles?(number, preamble_set)
    end
    -1
  end

  def sum_of_range_ends_summing_to(target_number)
    puts "target number: #{target_number}"
    @numbers.each_with_index do |x,i|
      next if x == target_number
      numbers_to_check = @numbers[i..-1]
      puts "*** Starting x = #{x}"
      y = sum_in_list_ending(target_number, x, numbers_to_check)
      return x + y if y != -1
    end
  end

  private

  def sum_in_list_ending(target_number, x, numbers_to_check)
    sum = x
    numbers_to_check.each do |y|
      next if x == y
      puts "Checking y = #{y}"
      sum += y
      if (sum == target_number)
        puts "**** Found a sum #{sum} = #{target_number} ****"
        return y
      end
      break if sum > target_number
    end

    -1
  end

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