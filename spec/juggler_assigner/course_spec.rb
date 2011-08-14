require File.dirname(__FILE__) + '/../spec_helper'

module JugglerAssigner
  describe Course do
    describe "init" do
      it "should initialize correctly provided the correct constructor args" do
        course = Course.new "C C0 H:7 E:7 P:10"
        course.name.should == "C0"
        course.coordination.should == 7
        course.endurance.should == 7
        course.pizzazz.should == 10
      end

      it "should shit the bed if the init string is malformed" do
        lambda { Course.new("foo") }.should raise_error
      end
    end
  end
end