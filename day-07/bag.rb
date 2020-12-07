class Bag
  @bag_rules = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @bag_rules = clean(raw_data)
  end

  def write_bag_rules
    @bag_rules.each_with_index do |rule, i|
      puts "rule #{i}: #{rule}"
    end
  end

  def can_contain(bag_type)
    # split the bag data on the contain word into hash
    # search the values for any matches. Get the keys
    # for each key, call this function??
  end

  private

  def clean(raw_data)
    clean_data = []

    raw_data.each do |row|
      clean_data << row.gsub(/\R+/, '')
    end

    clean_data
  end
end