module JugglerAssigner
  class Parser

    attr_accessor :file_name, :courses, :jugglers

    def initialize(file_name)
      self.file_name = file_name
      self.courses = Array.new
      self.jugglers = Array.new
    end

    def parse
      file = File.new(self.file_name, "r")

      file.each do |line|
        parse_line(line)
      end

      return self.courses, self.jugglers
    end

    private

    def parse_line(line)
      if line[0].eql?("C")
        parse_course(line)
      elsif line[0].eql?("J")
        parse_juggler(line)
      end
    end

    def parse_course(line)
      c = JugglerAssigner::Course.new(line)
      @courses << c
    end


    def parse_juggler(line)
      j = JugglerAssigner::Juggler.new(line)
      @jugglers << j
    end
  end
end