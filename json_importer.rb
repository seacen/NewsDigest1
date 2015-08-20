require 'open-uri'
require 'json'
require 'net/http'
require_relative 'news.rb'
# Json Importer
class JsonImporter < News::Importer
  def initialize(start_date, end_date)
    super
  end

  def scrape
    uri = URI(@url)
    response = Net::HTTP.get(uri)
    articles = JSON.parse(response)

    add_to_base(articles)
  end
end
