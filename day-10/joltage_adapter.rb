class JoltageAdapter
  @adapters = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @adapters = clean(raw_data)
    @one_jumps = 0
    @three_jumps = 0
  end

  def write_adapters
    @adapters.each_with_index do |adapter, i|
      puts "adapter #{i}: #{adapter}"
    end
  end

  def product_of_jolt_jumps
    # initial jump from the outlet rated at 0 jolts
    jump @adapters[0], 0

    @adapters.each_with_index do |adapter, i|
      if (i + 1) < @adapters.length
        jump @adapters[i + 1], adapter
      end
    end

    # last jump to the device which is 3 jolts more than the highest adapter
    jump @adapters[-1] + 3, @adapters[-1]

    puts "Final: one_jumps = #{@one_jumps} | three_jumps = #{@three_jumps}"
    @one_jumps * (@three_jumps)
  end

  def distinct_paths
    device_jolts = @adapters[-1] + 3

    puts "*" * 80
    connect_adapters(-1, 0, device_jolts)
  end

  private

  def connect_adapters(adapter_position, adapter_jolts, device_jolts)
    puts "#{adapter_jolts} !" * 120
    puts "adapter_position: #{adapter_position}, adapter_jolts: #{adapter_jolts}, device_jolts: #{device_jolts}"
    connections = 0
    remaining_adapters = []

    # check the one passed in
    return 1 if is_last_adapter?(adapter_jolts, device_jolts)

    # get the next set
    next_adapter_position = adapter_position + 1
    puts "#{adapter_jolts} next adapter_position = #{next_adapter_position}"
    remaining_adapters = @adapters[next_adapter_position..-1]
    puts "#{adapter_jolts} remaining_adapters = #{remaining_adapters}"
    puts "#{adapter_jolts} -------------"

    # process the next set
    remaining_adapters.each_with_index do |remaining_adapter, i|
      remaining_adapter_position = next_adapter_position + i
      jump_size = (remaining_adapter - adapter_jolts)
      puts "#{adapter_jolts} RA: #{remaining_adapter}: jump size = #{jump_size}"
      puts "#{adapter_jolts} breaking" if jump_size > 3
      break if jump_size > 3
      puts "#{adapter_jolts} Skipping" if jump_size == 2
      next if jump_size == 2
      puts "#{adapter_jolts} RA: #{remaining_adapter}: &&& remaining_adapter_position: #{remaining_adapter_position} remaining_adapter: #{remaining_adapter} device_jolts: #{device_jolts}"
      counter = connect_adapters(remaining_adapter_position, remaining_adapter, device_jolts)
      connections += counter
      puts "#{adapter_jolts} has #{connections} connections and counting"
    end
    puts "#{adapter_jolts} has #{connections} connections total"
    connections
  end

  def is_last_adapter?(adapter_jolts, device_jolts)
    puts "THis is the Last adapter" if adapter_jolts + 3 == device_jolts
    return true if adapter_jolts + 3 == device_jolts
    false
  end

  def jump(next_adapter, first_adapter)
    jump_size = next_adapter - first_adapter
    if jump_size == 3
      @three_jumps += 1
    else
      @one_jumps += 1
    end
    puts "Adapters: #{next_adapter} - #{first_adapter} = #{jump_size}"
    puts "one_jumps = #{@one_jumps} | three_jumps = #{@three_jumps}"
  end

  def clean(raw_data)
    clean_data = []
    raw_data.each do |row|
      clean_data << row.gsub(/\R+/, '').to_i
    end
    clean_data.sort!
  end
end