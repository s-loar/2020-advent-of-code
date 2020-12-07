class CustomsDocument
  @documents = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @documents = clean(raw_data)
  end

  def write_customs_documents
    @documents.each_with_index do |document, i|
      puts "document #{i}: #{document}"
    end
  end

  def sum_of_group_yes
    total_yes = 0
    yes_counter = {}

    @documents.each do |document|
      if document.empty?
        puts "yes_counter: #{yes_counter.size}"
        total_yes += yes_counter.size
        yes_counter = {}
        next
      end

      answers = document.split('').sort
      puts "answers: #{answers.join("")}"
      answers.each do |question|
        yes_counter[question] = 1
      end
    end
    puts "yes_counter: #{yes_counter.size}"
    total_yes += yes_counter.size

    puts "total_yes: #{total_yes}"
    total_yes
  end

  def agreed_group_yes
    total_yes = 0
    yes_counter = Hash.new(0)
    group_size = 0

    @documents.each do |document|
      if document.empty?
        puts "yes_counter: #{yes_counter}"
        total_yes += agreed_by_group_count(yes_counter, group_size)
        yes_counter = Hash.new(0)
        group_size = 0
        next
      end

      group_size += 1
      answers = document.split('').sort
      answers.each do |question|
        yes_counter[question] += 1
      end
    end

    puts "yes_counter: #{yes_counter}"
    total_yes += agreed_by_group_count(yes_counter, group_size)

    total_yes
  end

  private

  def agreed_by_group_count(yes_hash, group_size)
    agreed_answers = yes_hash.reject{|k,v|v != group_size}.keys.size
    puts "group_size: #{group_size} | agreed_answers: #{agreed_answers}"
    agreed_answers
  end

  def clean(raw_data)
    clean_data = []

    raw_data.each do |row|
      clean_data << row.gsub(/\R+/, '')
    end

    clean_data
  end
end