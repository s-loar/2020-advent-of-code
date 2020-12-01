class ExpenseReport
  @expenses = []

  def initialize
    @expenses = File.readlines('./input.txt')
  end

  def write_expenses
    @expenses.each do |expense|
      puts expense
    end
  end

  def two_number_solution
    @expenses.each_with_index do |x, outer_index|

      @expenses.each_with_index do |y, inner_index|
        next if outer_index == inner_index

        if (x.to_i + y.to_i) == 2020
          puts "solution:"
          puts "x: " + x
          puts "y: " + y
          puts "multiplied: " + (x.to_i * y.to_i).to_s
          return
        end
      end
    end
    puts "No 2 expenses added to 2020"
  end

  def three_number_solution
    @expenses.each_with_index do |x, x_index|

      @expenses.each_with_index do |y, y_index|
        next if x_index == y_index

        @expenses.each_with_index do |z, z_index|
          next if (y_index == z_index || x_index == z_index)
          if (x.to_i + y.to_i + z.to_i) == 2020
            puts "solution:"
            puts "x: " + x
            puts "y: " + y
            puts "z: " + z
            puts "multiplied: " + (x.to_i * y.to_i * z.to_i).to_s
            return
          end
        end
      end
    end
    puts "No 3 expenses added to 2020"
  end
end
