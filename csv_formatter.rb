require_relative 'news.rb'
# CSV Formatter
class CsvFormatter < News::Formatter
  def initialize
    super
  end

  def extension
    'csv'
  end

  def header?
    true
  end

  def header(article)
    keys = []
    filter(article, keys, 0)
    keys.join(', ')
  end

  def footer?
    false
  end

  def article_representation(article)
    values = []
    filter(article, values, 1)
    values.map(&:to_s).join(', ')
  end

  private

  def filter(article, array, num)
    article.attributes.each do |pair|
      if !pair[1]
        next
      else
        if num == 1 && (pair[0] == 'summary' || pair[0] == 'title')
          array << pair[num].delete(',')
        else
          array << pair[num]
        end
      end
    end
  end
end
