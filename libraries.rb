require 'nokogiri'
require 'open-uri'
require 'csv'

url = 'https://en.wikipedia.org/wiki/List_of_libraries'

html = URI.open(url)
doc = Nokogiri::HTML(html)

libraries_names = []
selector = doc.css('#mw-content-text div ul:nth-child(n+9):nth-child(-n+82) li')
selector.each do |library|
  libraries_names << library.text.split(',').first
  # puts library.text.split(',').first
end

csv_path = File.join(__dir__, 'libraries.csv')

CSV.open(csv_path, 'w') do |csv|
  csv << ['ID', 'Libraries Name']
  id = 1

  libraries_names.each do |library_name|
    csv << [id, library_name]

    id += 1
  end
end
