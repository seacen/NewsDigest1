# This class demonstrates how to extend the dummy importer to returned
# canned article. It serves as a demonstration only, and would not
# receive any marks nor is it indicative of the level of functionality
# we are expecting
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
#
# You should not include or use this file in your submission
#

require 'date'
require_relative 'news.rb'

class DummyImporter < News::Importer

	# We call super in the initialize method
	def initialize start_date, end_date
		super
	end

	# Define the class method for file_name, this should
	# return something similar to the name for your importer
	def self.source_name
		"dummy_source"
	end

	# Define a dummy scrape method that saves canned article data
	def scrape
		article_one = News::Article.new(author: 'Mat',
			title: 'Dummy', summary: 'Some really long string',
			images: 'www.some_image.com', source: 'Canned Data', date: Date.today)
		article_two = News::Article.new(author: 'Ed',
			title: 'Dummy', summary: 'Some really long string',
			images: 'www.some_image.com', source: 'Canned Data', date: Date.today)
		article_three = News::Article.new(author: 'Jess',
			title: 'Dummy', summary: 'Some really long string',
			images: 'www.some_image.com', source: 'Canned Data', date: Date.today)
		@articles.concat([article_one,article_two,article_three])
	end


end
