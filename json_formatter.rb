require_relative 'news.rb'
require 'json'
# JSON Formatter
class JsonFormatter < News::Formatter
  KEY = 0
  VAL = 1
  def initialize
    super
  end

  def extension
    'json'
  end

  def header?
    true
  end

  def header(article)
    # for identifying first article in the array in later function
    @head = article.title
    "{\n\"articles\":["
  end

  def footer?
    true
  end

  def footer(_article)
    "]\n}"
  end

  def article_representation(article)
    arti_hash = article.attributes
    arti_hash.each do |pair|
      # remove nil value pair from hash
      arti_hash.delete(pair[KEY]) unless pair[VAL]
    end
    result = JSON.pretty_generate(arti_hash)
    # not printing comma at front that separates article json objects
    # if the article is the first one
    if article.title == @head
      result
    else
      ',' + result
    end
  end
end
