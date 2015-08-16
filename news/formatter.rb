# This class forms an interface for formatting news article objects
# for output printing. You should extend this class to create the required
# formatters for each project task. Be sure to implement the required methods
# in your provided subclass
#
# Author::    Mathew Blair (mathew.blair@unimelb.edu.au)
# Copyright:: Copyright (c) 2015 The University Of Melbourne
#
# You should not need to modify this file for your submission
#
module News
  class Formatter

    # Initialize will simply perform validations on method implementation
    def initialize
      validate_subclasses
    end

    private
    # Validate that any subclass defines the required instance methods
    def validate_subclasses
      if not(self.respond_to?(:extension))
        throw Exception.new("subclass does not define file format extension")
      elsif not(self.respond_to?(:header?))
        throw Exception.new("subclass does not define the header check")
      elsif not(self.respond_to?(:article_representation))
        throw Exception.new("subclass does not define the article_representation")
      elsif not(self.respond_to?(:footer?))
        throw Exception.new("subclass does not define the footer check")
      end

      if (self.respond_to?(:header?) && self.header? && not(self.respond_to?(:header)))
        throw Exception.new("subclass states it has a header but does not define output")
      end

      if (self.respond_to?(:footer?) && self.footer? && not(self.respond_to?(:footer)))
        throw Exception.new("subclass states it has a footer but does not define output")
      end
    end
  end
end
