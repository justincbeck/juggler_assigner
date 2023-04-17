module JugglerAssigner
  class Parser

    attr_accessor :courses, :jugglers

    @file_name

    def initialize(file_name)
      @file_name = file_name
      @courses = Array.new
      @jugglers = Array.new
    end

    def parse
      file = File.new(@file_name, "r")

      file.each do |line|
        parse_line(line)
      end

      return self.courses, self.jugglers
    end

    private

    def parse_line(line)
      if line[0].eql?("N")
        parse_course(line)
      elsif line[0].eql?("H")
        parse_juggler(line)
      end
    end

    def parse_course(line)
      course = Course.new(line)
      @courses << course
    end


    def parse_juggler(line)
      juggler = Juggler.new(line, @courses)
      @jugglers << juggler
    end
  end
end