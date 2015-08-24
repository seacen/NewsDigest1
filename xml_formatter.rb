require_relative 'news.rb'
# JSON Formatter
class XmlFormatter < News::Formatter
  KEY = 0
  VAL = 1
  def initialize
    super
  end

  def extension
    'xml'
  end

  def header?
    true
  end

  def header(_article)
    %(<?xml version="1.0" encoding="utf-8"?>\n<articles>)
  end

  def footer?
    true
  end

  def footer(_article)
    '</articles>'
  end

  def article_representation(article)
    result = "\t<article>\n"
    article.attributes.each do |pair|
      # skip nil value pair
      next unless pair[VAL]

      obrace = "\t\t<#{pair[KEY]}>"
      cbrace = "</#{pair[KEY]}>\n"
      result += (obrace + pair[VAL].to_s + cbrace)
    end
    result += "\t</article>\n"
  end
end
