module JugglerAssigner
  class Juggler
    attr_accessor :name, :assigned, :coordination, :endurance, :pizzazz, :preferences, :assigned_course, :dot_product

    def initialize line
      parts = line.split /\s/

      self.assigned = false
      self.name = parts[1]
      self.coordination = parts[2].split(/:/)[1].to_i
      self.endurance = parts[3].split(/:/)[1].to_i
      self.pizzazz = parts[4].split(/:/)[1].to_i
      self.preferences = parts[5].split(/,/)
    end

    def calculate_dot_product(c)
      cp = c.coordination * self.coordination
      ep = c.endurance * self.endurance
      pp = c.pizzazz * self.pizzazz

      self.dot_product = cp + ep + pp
      self.dot_product
    end
  end
end