require 'wikipedia'
require 'json'
require 'debugger'
require 'nokogiri'
class Wiki
  def initialize(page,options)
    title = page.split("\/").last
    puts title
    @page = Wikipedia.find(title,options)
    tables
  end
  def tables
    @npage = Nokogiri::HTML(@page.content)
    @tables = @npage.css('table.wikitable')
  end

  def parse_table
    table = @tables.first
    headers = Array.new

    table.children.css('tr').first.css('th').each do |child|
      text = child.text.strip!
      text = text.gsub!(' ','')
      headers << text
    end
    headers = ['first','second','third']
    print headers
    total = Array.new
    table.children.css('tr').drop(1).each do |child|
      content = Hash.new
      headers.zip(child.css('td')).each do
        |header,element|
        unless (element.nil?)
          content_txt = element.text.strip!
        content[header] = content_txt
        end
      end
      total << content
    end
    return total.reject!{|element| element.empty?}.to_json
  end
  def title
    @page.title
  end

  def page
    @page
  end
end
