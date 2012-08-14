module JugglerAssigner
  class Juggler
    attr_accessor :name, :coordination, :endurance, :pizzazz, :assigned, :courses

    def initialize(line, all_courses)
      parts = line.split /\s/

      @assigned = false
      @name = parts[1]
      @coordination = parts[2].split(/:/)[1].to_i
      @endurance = parts[3].split(/:/)[1].to_i
      @pizzazz = parts[4].split(/:/)[1].to_i
      @courses = assign_preferred_courses(parts[5].split(/,/), all_courses)
    end

    def dot_product(c)
      cp = c.coordination * @coordination
      ep = c.endurance * @endurance
      pp = c.pizzazz * @pizzazz

      cp + ep + pp
    end

    private

    def assign_preferred_courses(preferences, all_courses)
      courses = Array.new
      preferences.each do |p|
        courses << all_courses.find { |c| c.name.eql? p }
      end
      @courses = courses
    end
  end
end