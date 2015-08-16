# This script demonstrates how you would go about using the news scraper,
# adding in a basic dummy importer that returns canned data and then
# exports that to file
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne

# Import the news scraper
require_relative 'news'
require_relative 'dummy_importer.rb'
require_relative 'dummy_formatter.rb'

# Implement a news scraper
scraper = News::Scraper.new

# Register the source and importer/formatter
scraper.register_source :dummy_source, DummyImporter, DummyFormatter

# Run the scrape
scraper.scrape
