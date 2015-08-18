require_relative 'rss_importer.rb'
require 'date'

# HeraldSun RSS Importer
class HsRssImporter < RssImporter
  def initialize(start_date, end_date)
    super
    @url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_breakingnews_2800.xml'
  end

  def self.source_name
    'Herald Sun Breaking News'
  end
end

a = HsRssImporter.new(Date.today - 7, Date.today)
a.scrape
a.articles.each do |article|
  p article
end
