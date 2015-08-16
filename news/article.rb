# This class provides a generic data type for a news article, you may
# wish to extend this for certain data sources. You should do this by
# inheriting this class from specific classes. You should also do this
# to allow the creatino of news articles from source data points.
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
module News
  class Article

    attr_reader :auther, :title, :summary, :images, :source, :date

    # Initialize the news article, using named paraters to associate
    # the author, title, summary, images, source
    def initialize author:, title:, summary:, images:, source:, date:
        @author = author
      @title = title
      @summary = summary
      @images = images
      @source = source
      @date = date
    end

    # Returns all of the attributes of an article as a hash.
    def attributes
      hash = {
        "author" => @author,
        "title" => @title,
        "summary" => @summary,
        "images" => @images,
        "source" => @source,
        "date" => @date
      }
    end
  end
end
