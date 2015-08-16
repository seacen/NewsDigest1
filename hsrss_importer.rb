require_relative 'news.rb'
require 'rss'
require 'open-uri'
require 'date'

# HeraldSun RSS Importer
class HsRssImporter < News::Importer
  def initialize(start_date, end_date)
    super
  end

  def self.source_name
    'Herald Sun Breaking News'
  end

  def scrape
    url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_breakingnews_2800.xml'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      add_to_base(feed)
    end
  end

  private

  def add_to_base(feed)
    feed.items.each do |item|
      date = item.pubDate.to_date

      if @start > date || @end < date
        next
      end
      if item.enclosure
        image = item.enclosure.url
      else
        image = nil
      end

      @articles << News::Article.new(author: item.source.content,
                                     title: item.title,
                                     summary: item.description,
                                     images: image,
                                     source: item.guid.content, date: date)
    end
  end
end

# a = HsRssImporter.new(Date.today - 7, Date.today)
# a.scrape
# a.articles.each do |article|
#   p article
# end
