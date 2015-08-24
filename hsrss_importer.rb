require_relative 'rss_importer.rb'
require 'date'

# HeraldSun RSS Importer
class HsRssImporter < RssImporter
  def initialize(start_date, end_date)
    super
    # source link
    @url = 'http://feeds.news.com.au/heraldsun/rss/heraldsun_news_breakingnews_2800.xml'
  end

  def self.source_name
    'Herald Sun Breaking News'
  end

  private

  # add a single article to the ariticle base in News::Article
  def add_to_base(item)
    info = validate_article(item)

    return unless info
    @articles << News::Article.new(author: item.source.content.delete("\n"),
                                   title: item.title.delete("\n"),
                                   summary: item.description.delete("\n"),
                                   images: info[1],
                                   source: item.link, date: info[0])
  end

  # validate if the given item is a valid article based on the date constraint
  # also check if an image is present in the source given
  def validate_article(item)
    date = item.pubDate.to_date
    return false if @start > date || @end < date

    if item.enclosure
      image = item.enclosure.url
    else
      image = 'Not Available'
    end

    [date, image]
  end
end
