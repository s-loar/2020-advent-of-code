class BoardingPass
  @boarding_passes = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @boarding_passes = clean_boarding_passes(raw_data)
  end

  def write_boarding_passes
    @boarding_passes.each_with_index do |pass, i|
      puts "Pass #{i.to_s}: #{pass}"
    end
  end

  def highest_seat_id
    highest_id = 0

    @boarding_passes.each do |pass|
      puts "pass: #{pass}"
      row = row_number(pass)
      # puts "Row: #{row}"
      column = column_number(pass)
      # puts "Column: #{column}"
      seat_id_number = seat_id(row, column)
      puts "Seat ID: #{seat_id_number}"
      highest_id = seat_id_number if seat_id_number > highest_id
    end

    highest_id
  end

  private

  def row_number(pass)
    front = 0
    back = 127
    # puts "starting => front: #{front} back: #{back}"

    rows = pass.split('').select{ |x| "BF".include?(x) }
    rows.each do |row_direction|
      if row_direction == 'F'
        back = upper_half(back, front)
      else
        front = lower_half(back, front)
      end
      # puts "#{row_direction} => front: #{front} back: #{back}"
    end
    front
  end

  def upper_half(high, low)
    ((high + 1 - low) / 2) - 1 + low
  end

  def lower_half(high, low)
    (((high + 1) - low) / 2) + low
  end

  def column_number(pass)
    left = 0
    right = 7
    # puts "starting => left: #{left} right: #{right}"

    columns = pass.split('').select{ |x| "LR".include?(x) }

    columns.each do |column_direction|
      if column_direction == 'L'
        right = upper_half(right, left)
      else
        left = lower_half(right, left)
      end
      # puts "#{column_direction} => left: #{left} right: #{right}"
    end

    left
  end

  def seat_id(row, column)
    row * 8 + column
  end

  def clean_boarding_passes(raw_data)
    clean_passes = []

    raw_data.each do |row|
      clean_passes << row.gsub(/\R+/, '')
    end

    clean_passes
  end
end