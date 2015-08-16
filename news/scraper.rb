# This class makes use of the generic importer and exporter
# classes to facilitate the scraping of various news feeds. You
# must use this class in your driver script by adding your importers
# and formatters to it, and then calling the scrape method.
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
#
# You should not need to modify this file for this project.
#

require 'date'
require_relative 'article.rb'
require_relative 'formatter.rb'
require_relative 'importer.rb'

module News

  class Scraper

    # Initialize the scraper with empty hashes of importers
    # and formatters
    def initialize
      @importers = {}
      @formatters = {}
    end

    # Register an importer and formatter, the name provided will
    # be used as the key to both the importer and formatter hash
    def register_source source, importer, formatter
      # Verify source arguments
      verify_source_arguments source, importer, formatter

      # Set the importer and expoer
      @importers[source] = importer
      @formatters[source] = formatter
    end

    # Remove a source from the scraper, after checking that soure
    # is the correct type of argument
    def remove_source source
      # Check it exists
      fail ArgumentError, "#{source} must be a string or symbol" unless (source.responds_to?(:to_s))
      fail ArgumentError, "#{source} has not been registered" if @importers[source].nil?

      @importers.delete(source)
      @formatters.delete(source)
    end


    # Run all the importers and export with formatter
    def scrape
      # Set our start and end date
      start_date = ::Date.today - 7
      end_date = ::Date.today

      # Count for reporting at the end
      count = 0

      # For each importer, iterate through the keys and importers
      # and instantiate an importer with the date range.
      # Then scrape and collect articles, before exporting
      @importers.each_pair do |key, importer_klass|
        instance = importer_klass.new(start_date, end_date)
        instance.scrape
        formatter = @formatters[key].new
        exporter = Exporter.new importer_klass, formatter
        exporter.export(instance.articles)
        count += instance.articles.count
      end

      # Report back to the use
      $stderr.puts "Succesfully scraped and exported #{count} articles from #{@importers.count} sources."
    end

    private

    # verify method arguments for assignment
    def verify_source_arguments source, importer, formatter
      # Fail if already registered (require explicit removal rather than overwrite)
      fail ArgumentError, "#{source} has already been registered" if @importers[source]

      # Fail if either importer or exporter is not a class
      fail ArgumentError, "importer must be provided as class not object" unless (importer.superclasses.include? Importer)
      fail ArgumentError, "exporter must be provided as class not object" unless (formatter.superclasses.include?(Formatter))

      # Fail if source is not a symbol
      fail ArgumentError, "source must be a symbol" unless (source.is_a?(Symbol) || source.is_a?(String))
    end

  end
end
