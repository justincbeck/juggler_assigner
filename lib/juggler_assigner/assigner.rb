module JugglerAssigner
  class Assigner

    @max_team_size
    @revoked

    def assign(courses, jugglers)
      @max_team_size = jugglers.size / courses.size if @max_team_size.nil?
      assignments = process(courses, jugglers)
      print(assignments) # To stout
      write(assignments) # To ../data/output.txt
    end

    def process(courses, jugglers)
      @revoked = Array.new

      jugglers.each do |j|
        if !j.assigned
          j.preferences.each do |c|
            assign_juggler(c, j) unless j.assigned
          end

          if !j.assigned
            courses.sort! { |x, y| j.calculate_dot_product(y) <=> j.calculate_dot_product(x) }.each do |c|
              assign_juggler(c, j) unless j.assigned
            end
          end
        end
      end

      process(courses, @revoked) unless @revoked.size == 0

      courses
    end

    private

    def assign_juggler(course, juggler)
      if course.jugglers.size < @max_team_size
        juggler.assigned = true
        juggler.assigned_course = course

        course.jugglers << juggler
      else
        force_assign_juggler(course, juggler)
      end
    end

    def force_assign_juggler(course, juggler)
      sorted_jugglers = course.jugglers.sort { |x, y| y.calculate_dot_product(course) <=> x.calculate_dot_product(course) }
      sorted_jugglers.each do |j|
        if juggler.calculate_dot_product(course) > j.calculate_dot_product(course)
          r = sorted_jugglers.delete(sorted_jugglers.last)
          course.jugglers = sorted_jugglers
          r.assigned = false
          r.assigned_course = nil

          @revoked << r

          assign_juggler(course, juggler)
        end
        break if juggler.assigned
      end
    end

    def print(courses)
      courses.sort! { |x, y| x.name.slice(/\d+/).to_i <=> y.name.slice(/\d+/).to_i }.each do |c|
        puts "Course Name: " + c.name
        puts "Jugglers (by dot product): "
        c.jugglers.sort { |x, y| y.calculate_dot_product(c) <=> x.calculate_dot_product(c) }.each do |j|
          puts "  " + j.name + " (" + j.dot_product.to_s + ")"
        end
      end
    end

    def write(courses)
      out = File.new("../data/output.txt", "w+")
      courses.sort! { |x, y| x.name.slice(/\d+/).to_i <=> y.name.slice(/\d+/).to_i }.each do |c|
        line = c.name + ":"
        c.jugglers.sort { |x, y| y.calculate_dot_product(c) <=> x.calculate_dot_product(c) }.each do |j|
          line += " " + j.name
        end
        out.write(line + "\n")
      end
      out.flush
      out.close
    end
  end
end