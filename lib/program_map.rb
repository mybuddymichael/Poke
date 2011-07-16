class ProgramMap

  include ReadMap

  attr_reader :lines

  def initialize(pathfile)
    get_columns(pathfile)
    get_width
    get_height
  end

  private

  def get_paths
    @n = 0

    @width.times do |x|
      @x = x

      @height.times do |y|
        @y = y

        next if current_cell == "."

        if current_cell == "p"
          if to_the_left == "." and above == "."
            @n += 1
            mark_upper_left_boundary
          elsif to_the_right == "." and above == "."
            mark_upper_right_boundary
          end

          if to_the_left == "." and below == "."
          end
        end

      end
    end
  end

  def current_cell
    @map_in_columns[@x][@y]
  end

  def above
    @map_in_columns[@x][@y-1]
  end

  def below
    @map_in_columns[@x][@y+1]
  end

  def to_the_left
    @map_in_columns[@x-1][@y]
  end

  def to_the_right
    @map_in_columns[@x+1][@y]
  end

  def mark_upper_left_boundary
    instance_variable_set("@path#{@n}", Hash.new)
    path = instance_variable_get("@path#{@n}")
    path[up: @y, left: @x]
  end

  def mark_upper_right_boundary
    @path[up: @y, right: (@x+1)]
  end

  def mark_bottom_left_boundary
    @path[down: (@y+1), left: @x]
  end

  def mark_bottom_right_boundary
    @path[down: (@y+1), right: (@x+1)]
  end

end
