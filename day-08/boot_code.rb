class BootCode
  @instructions = Hash.new

  def initialize
    raw_data = File.readlines('./input.txt')
    @instructions = clean(raw_data)
  end

  def write_instructions
    @instructions.each do |key, value|
      puts "instruction #{key} => #{value}"
    end
  end

  def last_uniq_command
    used_keys = []
    uniq_key = true
    line_no = 0
    accumulator = 0

    while uniq_key
      puts "command: #{@instructions[line_no]}"
      command = @instructions[line_no].split(' ')
      if command[0] == 'acc'
        accumulator += command[1].to_i
        puts "#{line_no} | acc: #{command[1]}"
        line_no += 1
      elsif command[0] == 'jmp'
        puts "#{line_no} | jmp: #{command[1]}"
        line_no += command[1].to_i
      else
        puts "#{line_no} | nop"
        line_no += 1
      end
      puts "looping accumulator: #{accumulator}"
      puts "New key: #{line_no} dup: #{used_keys.include?(line_no)}"
      uniq_key = false if used_keys.include?(line_no)
      used_keys << line_no
    end

    puts "final accumulator: #{accumulator}"
    accumulator
  end

  private

  def clean(raw_data)
    clean_data = Hash.new
    raw_data.each_with_index do |row, i|
      clean_data[i] = row.gsub(/\R+/, '')
    end
    clean_data
  end
end