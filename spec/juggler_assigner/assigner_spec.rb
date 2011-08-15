require File.dirname(__FILE__) + '/../spec_helper'

module JugglerAssigner
  describe Assigner do
    describe "assign" do
      it "should assign all jugglers to courses" do
        courses = [ Course.new("C C0 H:5 E:8 P:7") ]
        jugglers = [ Juggler.new("J J0 H:6 E:7 P:4 C0", courses), Juggler.new("J J1 H:7 E:4 P:9 C0", courses) ]
        assigner = Assigner.new("output.txt")
        assigner.assign(courses, jugglers)
      end
    end
  end
end
