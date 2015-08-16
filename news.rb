# This file defines the news module and requires all associated files for
# use in your project
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
#
# You should not need to modify this file for your submission
#

require_relative './news/importer.rb'
require_relative './news/article.rb'
require_relative './news/exporter.rb'
require_relative './news/formatter.rb'
require_relative './news/scraper.rb'

# Define the news module, you may want to put helper in here later
module News

end

# Add a helper method to basic object to return all superclasses 
# of a given object, allows us to make assertions about inheriting
# from a given base class when that class may be two or three abstractions
# away
class BasicObject
	# Recursively check if the class this is being called on has a superclass
	# and if so concatenate that result with ours. Omit Object and BasicObject
	# as they are not relevant.
	def self.superclasses
		if self.superclass.nil?
			return []
		else 
			supers = [self.superclass] + self.superclass.superclasses
			return supers - [::Object, ::BasicObject]
		end
	end

end

