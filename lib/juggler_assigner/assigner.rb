module JugglerAssigner
  class Assigner

    @max_team_size
    @revoked

    def process(courses = nil, jugglers = nil)
      @revoked = Array.new

      start = Time.new

      @max_team_size = jugglers.size / courses.size if @max_team_size.nil?

      # For each juggler
      jugglers.each do |j|
        if !j.assigned
          # First try to assign to a preferred course
          j.preferences.each do |c|
            assign_juggler(c, j) unless j.assigned
          end

          # If I couldn't assign to a preferred course, assign to the best match
          if !j.assigned
            # Sort the courses by their dot-product to the current juggler in descending order
            courses.sort! { |x, y| j.calculate_dot_product(y) <=> j.calculate_dot_product(x) }.each do |c|
              assign_juggler(c, j) unless j.assigned
            end
          end
        end
      end

      stop = Time.new
      puts "Elapsed time for this run: " + (stop - start).to_s + " seconds"

      process(courses, @revoked) unless @revoked.size == 0

      puts "All done!"
      print(courses)

    end

    private

    def calculate_dot_product(course, juggler)
      cp = course.coordination * juggler.coordination
      ep = course.endurance * juggler.endurance
      pp = course.pizzazz * juggler.pizzazz

      cp + ep + pp
    end

    def assign_juggler(course, juggler)
      if course.jugglers.size < @max_team_size
        # If the course has room then go ahead and assign this juggler to it
        juggler.assigned = true
        juggler.assigned_course = course

        course.jugglers << juggler
        puts "Inserting: " + juggler.name + " (" + juggler.calculate_dot_product(course).to_s + ") to " + course.name + " (" + course.jugglers.size.to_s + ")"
        puts
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

          puts "Revoking: " + r.name + " (" + r.calculate_dot_product(course).to_s + ") from " + course.name + " (" + course.jugglers.size.to_s + ")"
          revoked_s = "Revoked:"
          @revoked.each do |i|
            revoked_s += " "
            revoked_s += i.name
          end
          puts revoked_s

          assign_juggler(course, juggler)
        end
        break if juggler.assigned
      end
      if !juggler.assigned
        puts "Failed to assign: " + juggler.name + " to course: " + course.name + " (" + course.jugglers.size.to_s + ")"
      end
    end

    def print(courses)
      courses.sort! { |x, y| x.name.slice(/\d+/).to_i <=> y.name.slice(/\d+/).to_i }.each do |c|
        puts "Course Name: " + c.name
        puts "Jugglers (by dot product): "

        c.jugglers.sort! { |x, y| y.calculate_dot_product(c) <=> x.calculate_dot_product(c) }.each do |j|
          puts "  " + j.name
        end
      end
    end
  end
end