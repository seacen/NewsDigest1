require_relative 'json_importer.rb'
require_relative 'tg_article.rb'
require 'net/http'
require 'date'
# TheGuardian Json Importer
class TgJsonImporter < JsonImporter
  def initialize(start_date, end_date)
    super
    # source link
    base_url = 'http://content.guardianapis.com/search?'
    fromdate_q = "from-date=#{@start.strftime('%Y-%m-%d')}"
    todate_q = "&to-date=#{@end.strftime('%Y-%m-%d')}"
    sectionorder_q = '&section=australia-news&order-by=newest'
    api_q = '&api-key=q4gr8mvu6ekamy9hfnfvu74y'
    @url = base_url + fromdate_q + todate_q + sectionorder_q + api_q
  end

  def self.source_name
    'The Guardian Australia News'
  end

  private

  # add articles from response to the ariticle base in News::Article
  def add_to_base(response)
    response['response']['results'].each do |article|
      # convert string to date format to store in article class
      pub_date = Date.parse(article['webPublicationDate'][0..9])
      @articles << TgArticle.new(author: nil,
                                 title: article['webTitle'],
                                 summary: nil,
                                 images: nil,
                                 source: article['webUrl'],
                                 date: pub_date,
                                 type: article['type'],
                                 sectionId: article['sectionId'],
                                 id: article['id'],
                                 apiUrl: article['apiUrl'],
                                 sectionName: article['sectionName'])
    end
  end
end
