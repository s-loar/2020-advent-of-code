class BootCode
  @instructions = Hash.new
  @last_line = 0

  def initialize
    raw_data = File.readlines('./input.txt')
    @instructions = clean(raw_data)
    @last_line = @instructions.keys.last.to_i
  end

  def write_instructions
    @instructions.each do |key, value|
      puts "instruction #{key} => #{value}"
    end
  end

  def fixed_program_accumulator
    accumulator = 0
    used_keys = []
    line_no = 0
    fixed_commands = false

    while line_no <= @last_line
      puts "instruction #{line_no} => #{@instructions[line_no]}"
      command = @instructions[line_no].split(' ')
      if command[0] == 'acc'
        accumulator += command[1].to_i
        line_no += 1
      elsif command[0] == 'jmp'
        if fixed_commands
          line_no += command[1].to_i
        else
          old_command = @instructions[line_no]
          @instructions[line_no] = 'nop ' + command[1]
          if dup_found
            @instructions[line_no] = old_command
            line_no += command[1].to_i
          else
            fixed_commands = true
            line_no += 1
          end
        end
      else # nop
        if fixed_commands
          line_no += 1
        else
          old_command = @instructions[line_no]
          @instructions[line_no] = 'jmp ' + command[1]
          if dup_found
            @instructions[line_no] = old_command
            line_no += 1
          else
            fixed_commands = true
            line_no += command[1].to_i
          end
        end
      end
      used_keys << line_no
    end

    accumulator
  end

  def last_uniq_command
    used_keys = []
    uniq_key = true
    line_no = 0
    accumulator = 0

    while uniq_key
      # puts "command: #{@instructions[line_no]}"
      command = @instructions[line_no].split(' ')
      if command[0] == 'acc'
        accumulator += command[1].to_i
        # puts "#{line_no} | acc: #{command[1]}"
        line_no += 1
      elsif command[0] == 'jmp'
        # puts "#{line_no} | jmp: #{command[1]}"
        line_no += command[1].to_i
      else
        # puts "#{line_no} | nop"
        line_no += 1
      end
      # puts "looping accumulator: #{accumulator}"
      puts "New key: #{line_no} dup: #{used_keys.include?(line_no)}"
      uniq_key = false if used_keys.include?(line_no)
      used_keys << line_no
    end

    accumulator
  end

  private

  def dup_found
    used_keys = []
    uniq_key = true
    line_no = 0

    while uniq_key && line_no < @last_line
      command = @instructions[line_no].split(' ')
      if command[0] == 'acc'
        line_no += 1
      elsif command[0] == 'jmp'
        line_no += command[1].to_i
      else
        line_no += 1
      end
      # puts "New key: #{line_no} dup: #{used_keys.include?(line_no)}"
      uniq_key = false if used_keys.include?(line_no)
      used_keys << line_no
    end
    puts "Program fixed" if uniq_key
    !uniq_key
  end

  def clean(raw_data)
    clean_data = Hash.new
    raw_data.each_with_index do |row, i|
      clean_data[i] = row.gsub(/\R+/, '')
    end
    clean_data
  end
end