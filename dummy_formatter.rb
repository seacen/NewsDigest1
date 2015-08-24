# This class demonstrates how to extend the dummy formatter to returned
# canned csv data. It serves as a demonstration only, and would not receive
# any marks nor is it indicative of the level of functionality we are
# expecting
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
#
# You should not include or use this file in your submission
#
require_relative 'news.rb'

class DummyFormatter < News::Formatter

	# Call super to guarantee that our checks are run
	def initialize
		super
	end

	# Define dummy extension type
	def extension
		"csv"
	end

	# Return true for header
	def header?
		true
	end

	def footer?
		false
	end

	# Return canned header data
	def header article
		article.attributes.keys.join(', ')
	end

	# Return canned article representation
	def article_representation article
		article.attributes.values.map(&:to_s).join(', ')
	end

end
