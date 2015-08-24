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

  private

  def add_to_base(item)
    info = validate_article(item)

    return unless info

    @articles << News::Article.new(author: nil,
                                   title: item.title,
                                   summary: info[1],
                                   images: nil,
                                   source: item.link, date: info[0])
  end

  def validate_article(item)
    date = item.pubDate.to_date

    if @start > date || @end < date
      return false
    end
    if (m = item.description.match(%r{(.)*(<p>.*<\/p>)(.*)}))
      des = m[3]
    else
      des = item.description
    end

    [date, des]
  end
end

# a = TaRssImporter.new(Date.today - 7, Date.today)
# a.scrape
# a.articles.each do |article|
#   p article
# end
