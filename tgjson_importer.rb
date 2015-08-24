require_relative 'json_importer.rb'
require_relative 'tg_article.rb'
require 'net/http'
require 'date'
# TheGuardian Json Importer
class TgJsonImporter < JsonImporter
  def initialize(start_date, end_date)
    super
    @url = "http://content.guardianapis.com/search?from-date=#{@start.strftime('%Y-%m-%d')}&to-date=#{@end.strftime('%Y-%m-%d')}&section=australia-news&order-by=newest&api-key=q4gr8mvu6ekamy9hfnfvu74y"
  end

  def self.source_name
    'The Guardian Australia News'
  end

  private

  def add_to_base(response)
    response['response']['results'].each do |article|
      @articles << TgArticle.new(author: nil,
                                 title: article['webTitle'],
                                 summary: nil,
                                 images: nil,
                                 source: article['webUrl'],
                                 date: Date.parse(article['webPublicationDate'][0..9]),
                                 type: article['type'],
                                 sectionId: article['sectionId'],
                                 id: article['id'],
                                 apiUrl: article['apiUrl'],
                                 sectionName: article['sectionName'])
    end
  end
end

# a = TgJsonImporter.new(Date.today - 7, Date.today)
#
# p TgJsonImporter.source_name
# a.scrape
# a.articles.each { |article| p article.attributes }
