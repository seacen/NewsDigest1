require_relative 'rss_importer.rb'
require 'date'

# The Age RSS Importer
class TaRssImporter < RssImporter
  def initialize(start_date, end_date)
    super
    @url = 'http://www.theage.com.au/rssheadlines/world/article/rss.xml'
  end

  def self.source_name
    'The Age World News'
  end
end

a = TaRssImporter.new(Date.today - 7, Date.today)
a.scrape
a.articles.each do |article|
  p article
end
