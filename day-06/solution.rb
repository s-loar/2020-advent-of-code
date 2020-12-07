require_relative 'customs_document'

customs_document = CustomsDocument.new

customs_document.write_customs_documents

puts "First Problem - the sum of 'yes' answers is #{customs_document.sum_of_group_yes}"

puts "Second Problem - the sum of group agreed 'yes' answers is #{customs_document.agreed_group_yes}"