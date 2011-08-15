module JugglerAssigner
  class Course
    attr_accessor :name, :coordination, :endurance, :pizzazz, :jugglers

    def initialize line
      parts = line.split /\s/

      @name = parts[1]
      @coordination = parts[2].split(/:/)[1].to_i
      @endurance = parts[3].split(/:/)[1].to_i
      @pizzazz = parts[4].split(/:/)[1].to_i
      @jugglers = Array.new
    end
  end
end