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

    puts "Final: one_jumps = #{@one_jumps} | three_jumps = #{@three_jumps}"
    # add one 3 volt jump for the final connection to the device
    @one_jumps * (@three_jumps + 1)
  end

  private

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