class Grid

  def initialize(window, user, map, tileset, map_key, background)
    @window, @user = window, user
    @map = Map.new(window, map, tileset, map_key)
    @background  = Gosu::Image.new(window, background, false)
  end

  def start
    @window.set_current_grid_as(self)
  end

  def width
    @map.width
  end

  def height
    @map.height
  end

  def solid_blocks
    @map.solid_blocks
  end

  def lines
    @map.lines
  end

end
