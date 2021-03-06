module JugglerAssigner
  class Assigner

    @outfile
    @max_team_size
    @revoked

    def initialize(outfile)
      @outfile = outfile
    end

    def assign(courses, jugglers)
      @max_team_size = jugglers.size / courses.size
      assignments = process(courses, jugglers)
      write(assignments)
    end

    private

    def process(courses, jugglers)
      @revoked = Array.new

      jugglers.each do |j|
        j.courses.each do |c|
          break if j.assigned
          assign_juggler(c, j)
        end

        unless j.assigned
          courses.sort! { |x, y| j.dot_product(y) <=> j.dot_product(x) }.each do |c|
            break if j.assigned
            assign_juggler(c, j)
          end
        end
      end

      process(courses, @revoked) unless @revoked.size == 0

      courses
    end

    def assign_juggler(course, juggler)
      if course.jugglers.size < @max_team_size
        juggler.assigned = true
        course.jugglers << juggler
      else
        force_assign_juggler(course, juggler)
      end
    end

    def force_assign_juggler(course, juggler)
      sorted_jugglers = course.jugglers.sort { |x, y| y.dot_product(course) <=> x.dot_product(course) }
      sorted_jugglers.each do |j|
        if juggler.dot_product(course) > j.dot_product(course)
          r = sorted_jugglers.delete(sorted_jugglers.last)
          course.jugglers = sorted_jugglers
          r.assigned = false

          @revoked << r

          assign_juggler(course, juggler)
        end
        break if juggler.assigned
      end
    end

    def write(courses)
      out = File.new(@outfile, "w+")
      courses.sort! { |x, y| x.name.slice(/\d+/).to_i <=> y.name.slice(/\d+/).to_i }.each do |c|
        line = c.name + ":"
        c.jugglers.sort { |x, y| y.dot_product(c) <=> x.dot_product(c) }.each do |j|
          line += " " + j.name + "(" + j.dot_product(c).to_s + ")"
        end
        puts line
        out.write(line + "\n")
      end
      out.flush
      out.close
    end
  end
end