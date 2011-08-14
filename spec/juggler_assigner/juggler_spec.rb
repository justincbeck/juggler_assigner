require File.dirname(__FILE__) + '/../spec_helper'

module JugglerAssigner
  describe Juggler do
    describe "init" do
      it "should initialize correctly provided the correct constructor args" do
        courses = [Course.new("C C0 H:5 E:8 P:3"), Course.new("C C1 H:2 E:8 P:7")]
        juggler = Juggler.new("J J0 H:3 E:9 P:2 C0,C1", courses)
        juggler.coordination.should == 3
        juggler.endurance.should == 9
        juggler.pizzazz.should == 2
        juggler.courses.should == courses
      end
    end

    describe "dot_product" do
      it "should calculate the dot product of self and the course passed in" do
        courses = [Course.new("C C0 H:5 E:8 P:3"), Course.new("C C1 H:2 E:8 P:7")]
        juggler = Juggler.new("J J0 H:3 E:9 P:2 C0,C1", courses)
        juggler.dot_product(courses[0]).should == 93
        juggler.dot_product(courses[1]).should == 92
      end
    end
  end
end