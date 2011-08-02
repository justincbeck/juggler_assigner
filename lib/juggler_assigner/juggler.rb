module JugglerAssigner
  class Juggler
    attr_accessor :name, :assigned, :coordination, :endurance, :pizzazz, :preferences

    def initialize line
      parts = line.split /\s/

      self.assigned = false
      self.name = parts[1]
      self.coordination = parts[2].split(/:/)[1].to_i
      self.endurance = parts[3].split(/:/)[1].to_i
      self.pizzazz = parts[4].split(/:/)[1].to_i
      self.preferences = parts[5].split(/,/)
    end
  end
end