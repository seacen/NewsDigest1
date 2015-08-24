require_relative 'news.rb'
# TheGuardian Article storage format
class TgArticle < News::Article
  attr_reader :type, :sectionId, :id, :apiUrl, :sectionName

  def initialize(author:, title:, summary:, images:, source:, date:, type:, sectionId:, id:, apiUrl:, sectionName:)
    @type = type
    @section_id = sectionId
    @id = id
    @api_url = apiUrl
    @section_name = sectionName
    @author = author
    @title = title
    @summary = summary
    @images = images
    @source = source
    @date = date
  end

  def attributes
    hash = {
      "author" => @author,
      "title" => @title,
      "summary" => @summary,
      "images" => @images,
      "source" => @source,
      "date" => @date,
      'type' => @type,
      'sectionId' => @section_id,
      'id' => @id,
      'apiUrl' => @api_url,
      'sectionName' => @section_name
    }
  end
end
