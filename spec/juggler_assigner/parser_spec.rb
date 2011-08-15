require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

module JugglerAssigner
  describe Parser do
    describe "init" do
      it "should initialize correctly provided the correct constructor args" do
        parser = Parser.new("filename")
        parser.jugglers.should be_empty
        parser.courses.should be_empty
      end
    end

    describe "parse" do
      it "should parse the given file and create an array of courses and jugglers" do
        parser = Parser.new("data/small_juggle_course.txt")
        courses, jugglers = parser.parse
        courses.size.should == 3
        jugglers.size.should == 12
      end
    end
  end
end