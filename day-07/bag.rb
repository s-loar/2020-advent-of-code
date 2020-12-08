class Bag
  @bag_rules = Hash.new

  def initialize
    raw_data = File.readlines('./input.txt')
    @bag_rules = clean(raw_data)
  end

  def write_bag_rules(bags = @bag_rules)
    bags.each do |key, value|
      puts "rule #{key} => #{value}"
    end
  end

  def bags_containing(bag_type)
    puts "#{bag_type} can be withing the following bags"
    bags = containing(bag_type)
    puts bags.sort
    puts "total #{bags.length} bags"
  end

  def bags_contained_in(bag_type)
    puts "#{bag_type} contains the following bags"
    total_bag_count = contains(bag_type, 1)
    puts "#{bag_type} contains #{total_bag_count} bags"
  end

  private

  def contains(bag_type, bag_count)
    total_bags = 0
    bag_type = bag_type[0...-1] if bag_type[-1] == 's'
    bags = @bag_rules.select{|key, value| key.include?(bag_type)}
    bags.each do |key,value|
      puts "#{bag_type}: rule #{key}: #{value}"
      if value.include?('no other bags')
        puts "0 inner bags for #{bag_type}"
        return 0 if value.include?('no other bags')
      end
      inner_bags = value.split(', ')
      puts "#{bag_type} directly contains #{inner_bags.length} bag types"
      inner_bags.each do |inner_bag|
        bag = inner_bag.split(' ')
        number_of_inner_bag = bag[0].to_i * bag_count
        inner_bag_name = bag[1..].join(' ')
        puts "#{bag_type}: #{number_of_inner_bag} of #{inner_bag_name}"
        total_bags += (bag[0].to_i * bag_count) + contains(inner_bag_name, number_of_inner_bag)
      end
    end
    puts "** Total Bags for (#{bag_type}): #{total_bags}"
    total_bags
  end

  def containing(bag_type)
    key_bags = []
    bag_type = bag_type[0...-1] if bag_type[-1] == 's'
    bags = @bag_rules.select{|key, value| value.include?(bag_type)}
    puts "#{bag_type} is directly in #{bags.length} bags"
    bags.each do |key, value|
      puts "#{bag_type}: rule #{key}: #{value}"
      key_bags << key
      key_bags << containing(key)
    end
    key_bags.flatten.uniq
  end

  def clean(raw_data)
    clean_hash = Hash.new

    raw_data.each do |row|
      clean_data = row.gsub(/\R+/, '').gsub('.', '')
      tmp_array = clean_data.split('s contain ')
      clean_hash[tmp_array[0]] = tmp_array[1]
    end

    clean_hash
  end
end