require_relative 'news.rb'
# CSV Formatter
class CsvFormatter < News::Formatter
  KEY = 0
  VAL = 1
  def initialize
    super
  end
  # Define dummy extension type
  def extension
    'csv'
  end
  # Return true for header
  def header?
    true
  end

  def header(article)
    keys = []
    filter(article, keys, KEY)
    keys.join(', ')
  end

  def footer?
    false
  end

  def article_representation(article)
    values = []
    filter(article, values, VAL)
    values.map(&:to_s).join(', ')
  end

  private

  # remove the nil value hash pairs and add either remaining keys for header
  # or remaining values for rows to argument array according to the num number
  def filter(article, array, num)
    article.attributes.each do |pair|
      # skip nil value pair
      next unless pair[VAL]
      # If filtering VALs delete all commas from values to ensure proper format
      if num == VAL && %w(summary title author).include?(pair[KEY])
        array << pair[num].delete(',')
      else
        array << pair[num]
      end
    end
  end
end
