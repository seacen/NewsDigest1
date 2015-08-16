# This class forms the basis for a generic importer that you will write
# by extending this class and implementing the required methods. It provides
# an array data structure to store news items, methods to access these required
# by the exporter
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
#
# You are required to create subclasses of this class and in those
# classes you are required to create the methods scrape and file_name
#

require_relative 'article.rb'

module News
  class Importer

    # A news scrape is initialised with the start and end date, it
    # then validates that the required methods are provided
    def initialize start_date, end_date
      @start = start_date
      @end = end_date
      @articles = []
      validate_subclasses
    end

    # Method to return news articles, ensuring that we only return
    # unique news articles
    def articles
      @articles.uniq
    end

    private
    # Method to valid subclass implements the required methods
    def validate_subclasses
      # Validate instance methods
      if not(self.respond_to?(:scrape))
        throw Exception.new("subclass fails to implement the required scrape method")
      end

      # Validate class methods
      if not(self.class.respond_to?(:source_name))
        throw Exception.new("subclass fails to provide source_name")
      end

    end
  end
end
