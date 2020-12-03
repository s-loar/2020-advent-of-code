class TobogganRoute
  @map_rows = []
  @row_size = 0

  def initialize
    raw_map_rows = File.readlines('./input.txt')
    @map_rows = clean_map_rows(raw_map_rows)
    @row_size = @map_rows[0].length
  end

  def write_map_rows
    @map_rows.each_with_index do |map_row, i|
      puts "Row #{i} #{map_row}"
    end
  end

  def tree_count(offset_x, offset_y)
    travel(offset_x, offset_y)
  end

  private

  def travel(offset_x, offset_y)
    tree_count = 0
    current_x = offset_x
    current_y = offset_y

    while current_y < @map_rows.size do
      tree_count += 1 if @map_rows[current_y][current_x] == '#'
      current_y += offset_y
      current_x = (current_x + offset_x) % @row_size
    end

    tree_count
  end

  def clean_map_rows(raw_map_rows)
    new_map_rows = []
    raw_map_rows.each do |map_row|
      if map_row[-1] == "\n"
        new_map_rows << map_row.chop
      else
        new_map_rows << map_row
      end
    end
    new_map_rows
  end
end