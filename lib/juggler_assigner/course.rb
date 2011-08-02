module JugglerAssigner
  class Course
    attr_accessor :name, :coordination, :endurance, :pizzazz, :jugglers

    def initialize line
      parts = line.split /\s/

      self.name = parts[1]
      self.coordination = parts[2].split(/:/)[1].to_i
      self.endurance = parts[3].split(/:/)[1].to_i
      self.pizzazz = parts[4].split(/:/)[1].to_i
      self.jugglers = Array.new
    end
  end
end