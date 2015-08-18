require_relative 'news.rb'
require 'rss'
require 'open-uri'
require 'date'

# RSS Importer
class RssImporter < News::Importer
  def initialize(start_date, end_date)
    super
  end

  def scrape
    open(@url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        add_to_base(item)
      end
    end
  end

  private

  def add_to_base(item)
    info = validate_article(item)

    return unless info

    @articles << News::Article.new(author: info[2],
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
      image = nil
    end
    if item.source
      author = item.source.content
    else
      author = nil
    end

    [date, image, author]
  end
end
