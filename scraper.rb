require 'scraperwiki'
# Blank Ruby

require 'nokogiri'   
 
#query = URI.escape("link:www.stedaniels.co.uk")
query="test"

data = []

(0..9).each do |count|
  html = ScraperWiki::scrape("https://www.google.com/search?q=#{query}&start=#{count*10}")
  doc = Nokogiri::HTML(html)

  link = doc.search('h3')
  puts "Found #{link.size} results"

  link.each do |l| 
    a = l.search('a').first
    result = {
      :url => a['href'].gsub(/^\/url\?q\=/,'').gsub(/\&sa=.*$/, ''),
      :text => a.content
    }

    data << result
  end
end

data.flatten

p data

ScraperWiki::save_sqlite(['url', 'text'], data)
