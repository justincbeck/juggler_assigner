module JugglerAssigner
  class Assigner

    @max_team_size
    @courses
    @jugglers
    @failure

    def process(courses = nil, jugglers = nil)
      @courses = courses unless courses.nil?
      @jugglers = jugglers unless jugglers.nil?
      @failure = false

      start = Time.new

      @max_team_size = @jugglers.size / @courses.size

      @jugglers.each do |j|
        j.preferences.each do |c|
          assign_juggler(c, j) unless j.assigned
        end

        if !j.assigned
          @courses.sort! { |x, y| j.calculate_dot_product(y) <=> j.calculate_dot_product(x) }.each do |c|
            assign_juggler(c, j)
          end
        end
      end

      stop = Time.new
      puts "Elapsed time for this run: " + (stop - start).to_s + " seconds"

      puts "There are " + @jugglers.size.to_s + " jugglers remaining..."
      process unless @jugglers.size == 0 || @failure == true
      puts "Failure!!!" unless @failure == false

      puts "All done!"
      print

    end

    private

    def calculate_dot_product(course, juggler)
      cp = course.coordination * juggler.coordination
      ep = course.endurance * juggler.endurance
      pp = course.pizzazz * juggler.pizzazz

      cp + ep + pp
    end

    def assign_juggler(course, juggler)
      puts "Course: " + course.name
      puts "Assign Candidate: " + juggler.name
      if course.jugglers.size < @max_team_size
        puts "Before: " + @jugglers.size.to_s
        juggler.assigned = true
        juggler.assigned_course = course

        course.jugglers << juggler
        puts "Assigned: " + juggler.name
        puts "After: " + @jugglers.size.to_s
      else
        force_assign_juggler(course, juggler)
      end
      puts "*************************************"
    end

    def force_assign_juggler(course, juggler)
      sorted_jugglers = course.jugglers.sort { |x, y| y.calculate_dot_product(course) <=> x.calculate_dot_product(course) }
      sorted_jugglers.each do |j|
        if juggler.calculate_dot_product(course) > j.calculate_dot_product(course)
          revoked = sorted_jugglers.delete(sorted_jugglers.last)
          course.jugglers = sorted_jugglers
          if !@jugglers.include?(revoked)
            revoked.assigned = false
            revoked.assigned_course = nil

            @jugglers << revoked
          end

          assign_juggler(course, juggler)
        end
      end
      puts "Failed to assign: " + juggler.name
      @failure = true
    end

    def print
      @courses.sort! { |x, y| x.name.slice(/\d+/).to_i <=> y.name.slice(/\d+/).to_i }.each do |c|
        puts "Course Name: " + c.name
        puts "Jugglers (by dot product): "

        c.jugglers.sort! { |x, y| y.calculate_dot_product(c) <=> x.calculate_dot_product(c) }.each do |j|
          puts "  " + j.name
        end
      end
    end
  end
end