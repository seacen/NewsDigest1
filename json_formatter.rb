require_relative 'news.rb'
require 'json'
# JSON Formatter
class JsonFormatter < News::Formatter
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
    filter(article)
  end

  private

  def filter(article)
    arti_hash = article.attributes
    arti_hash.each do |pair|
      arti_hash.delete(pair[0]) unless pair[1]
    end
    result = JSON.pretty_generate(arti_hash)
    if article.title == @head
      result
    else
      ',' + result
    end
  end
end
