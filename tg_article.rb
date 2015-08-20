require_relative 'news.rb'
# TheGuardian Article storage format
class TgArticle < News::Article
  attr_reader :type, :sectionId, :id, :apiUrl, :sectionName

  def initialize(author:, title:, summary:, images:, source:, date:, type:, sectionId:, id:, apiUrl:, sectionName:)
    @type = type
    @sectionId = sectionId
    @id = id
    @apiUrl = apiUrl
    @sectionName = sectionName
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
      'sectionId' => @sectionId,
      'id' => @id,
      'apiUrl' => @apiUrl,
      'sectionName' => @sectionName
    }
  end
end
