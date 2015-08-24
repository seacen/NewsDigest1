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

  private

  def add_to_base(item)
    info = validate_article(item)

    return unless info

    @articles << News::Article.new(author: item.source.content,
                                   title: item.title,
                                   summary: item.description,
                                   images: info[1],
                                   source: item.link, date: info[0])
  end

  def validate_article(item)
    date = item.pubDate.to_date

    if @start > date || @end < date
      return false
    end
    if item.enclosure
      image = item.enclosure.url
    else
      image = 'Not Available'
    end

    [date, image]
  end
end

# a = HsRssImporter.new(Date.today - 7, Date.today)
# a.scrape
# a.articles.each do |article|
#   p article
# end
