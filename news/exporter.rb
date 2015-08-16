# This class forms the basis for a generic exporter that will use the
# formatter you provide to output to a file. It will find a file name, handle
# opening and closing a file for you and let you determine the formatter.
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
#
# You should not need to modify this file for your submission
#
require_relative './article.rb'

module News
  class Exporter

    # Initialize the news exporter passing in the importer class, we use
    # this to initalize the headers array.
    def initialize importer_class, formatter
      # First validate the formatter is a formatter
      fail Exception, "must include a valid subclass of News::Formatter" unless formatter.is_a? Formatter
      # If that does not throw an exception, then initialize
      @formatter = formatter
      # Find a non coliding file
      @file = retrieve_file importer_class.source_name, formatter.extension
    end

    # Generic method to export, will rely on subclasses to define the method for
    # string representation of each article line. Does things manually rather than
    # rely on the CSV library
    def export articles
      # Check if we need to print a header and if so, print it
      if @formatter.header?
        @file.puts @formatter.header(articles.first)
      end

      # Fail if any article is not an instance of News::Article
      fail Exception, "passed in articles array including non article objects" if articles.any? { |e| !e.is_a?(Article) }

      # Iterate through each article, write the output for that article from the formatter
      articles.each do |article|
        @file.puts @formatter.article_representation(article)
      end

      # Print footer if required
      if @formatter.footer?
        @file.puts @formatter.footer(articles.first) 
      end

    end

    private
    # Find a file that doesn't exist and open it so we get a lock on it.
    def retrieve_file source, extension
      file_name = collisionless_filename source, extension
      File.open(file_name, 'w+')
    end

    # Find an unused file name that is as close to the requested file
    # name as possible by appending numbers until we find one that doesn't collide
    def collisionless_filename source, extension
      base_name = "#{source}_scrape_#{Date.today.strftime('%Y-%m-%d')}.#{extension}"
      unused_filename = base_name
      n = 1
      while File.file?(unused_filename) do
          unused_filename = "#{base_name}_v#{n}.#{extension}"
          n += 1
      end
      unused_filename
    end
    
  end
end

