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
      seat_id_number = seat_id(pass)
      highest_id = seat_id_number if seat_id_number > highest_id
    end

    highest_id
  end

  def your_seat_id
    seat_ids = []
    open_seat = 0

    @boarding_passes.each do |pass|
      seat_ids << seat_id(pass)
    end
    seat_ids.sort!
    seat_ids.each_index do |i|
      if (seat_ids.length > (i + 1)) && ((seat_ids[i + 1]) - seat_ids[i] != 1)
        open_seat = seat_ids[i] + 1
      end
    end
    open_seat
  end

  private

  def row_number(pass)
    front = 0
    back = 127

    rows = pass.split('').select{ |x| "BF".include?(x) }
    rows.each do |row_direction|
      if row_direction == 'F'
        back = upper_half(back, front)
      else
        front = lower_half(back, front)
      end
    end
    front.to_i
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

    columns = pass.split('').select{ |x| "LR".include?(x) }

    columns.each do |column_direction|
      if column_direction == 'L'
        right = upper_half(right, left)
      else
        left = lower_half(right, left)
      end
    end

    left.to_i
  end

  def seat_id(pass)
    row = row_number(pass)
    column = column_number(pass)
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