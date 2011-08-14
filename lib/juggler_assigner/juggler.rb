module JugglerAssigner
  class Juggler
    attr_accessor :name, :assigned, :coordination, :endurance, :pizzazz, :courses
    def initialize line, all_courses
      parts = line.split /\s/

      self.assigned = false
      self.name = parts[1]
      self.coordination = parts[2].split(/:/)[1].to_i
      self.endurance = parts[3].split(/:/)[1].to_i
      self.pizzazz = parts[4].split(/:/)[1].to_i
      self.courses = assign_preferred_courses(parts[5].split(/,/), all_courses)
    end

    def dot_product(c)
      cp = c.coordination * self.coordination
      ep = c.endurance * self.endurance
      pp = c.pizzazz * self.pizzazz

      cp + ep + pp
    end

    private

    def assign_preferred_courses(preferences, all_courses)
      courses = Array.new
      preferences.each do |p|
        courses << all_courses.find { |c| c.name.eql? p }
      end
      self.courses = courses
    end
  end
end