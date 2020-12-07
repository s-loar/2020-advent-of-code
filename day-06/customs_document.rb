class CustomsDocument
  @documents = []

  def initialize
    raw_data = File.readlines('./input.txt')
    @documents = clean(raw_data)
  end

  def write_customs_documents
    @documents.each_with_index do |document, i|
      puts "document #{i.to_s}: #{document}"
    end
  end

  def sum_of_group_yes
    group_yes = 0
    total_yes = 0
    yes_counter = {}

    @documents.each do |document|
      # puts "Document row: #{document}"
      if document.empty?
        puts "yes_counter: #{yes_counter.size}"
        group_yes = 0
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

  private

  def clean(raw_data)
    clean_data = []

    raw_data.each do |row|
      clean_data << row.gsub(/\R+/, '')
    end

    clean_data
  end
end