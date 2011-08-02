module JugglerAssigner
  class Assigner

    @courses
    @jugglers

    @max_team_size


    def assign(courses, jugglers)
      sorted_courses = Array.new
      @max_team_size = jugglers.size / courses.size

      jugglers.each do |j|
        sorted_courses = courses.sort do |x, y|
          left = dot_product(x, j)
          right = dot_product(y, j)

          left <=> right
        end

        preferred_courses = sorted_courses.collect { |c| c if j.preferences.include? c.name }
        preferred = sorted_courses & preferred_courses
        preferred.each do |p|
          if p.jugglers.size < @max_team_size
            p.jugglers << j
            j.assigned = true
            break
          end
        end

        if !j.assigned
          sorted_courses.each do |c|
            if c.jugglers.size < @max_team_size
              c.jugglers << j
              j.assigned = true
              break
            end
          end
        end


      end

      sorted_courses.sort! { |x, y| x.name.slice(/\d+/).to_i <=> y.name.slice(/\d+/).to_i }.each do |c|
        puts "Course Name: " + c.name
        puts "Jugglers: "
        c.jugglers.each do |j|
          puts "  " + j.name
        end
      end
    end

    def dot_product(c, j)
      cp = c.coordination * j.coordination
      ep = c.endurance * j.endurance
      pp = c.pizzazz * j.pizzazz

      dp = cp + ep + pp
      dp
    end
  end
end