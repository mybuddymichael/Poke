class Window < Gosu::Window

  attr_reader :user, :current_grid, :buttons_pushed, :paused

  def initialize
    super(480, 320, false)
    self.caption = 'Poke'
    @width, @height = 480, 320

    @camera_x = @camera_y = 0

    @user         = User.new(self, 416, 288)
    @pause_screen = PauseScreen.new(self, @width, @height)

    @grid_one = GridOne.new(self, @user)
    @grid_one.start

    @buttons_pushed = []
  end

  def set_current_grid_as(grid)
    @current_grid = grid
  end

  def update
    unless @paused
      @current_grid.update
      @user.update
      @camera_x = [[@user.x - 224, 0].max, @current_grid.width * 32 - 480].min
      @camera_y = [[@user.y - 160, 0].max, @current_grid.height * 32 - 320].min
    end
  end

  def draw
    translate(-@camera_x, -@camera_y) do
      @current_grid.draw
      @user.draw
    end
    @current_grid.background.draw(0,0,ZOrder::Background)
    if @paused
      @pause_screen.draw
    end
  end

  def button_down(id)
    case id
    when Gosu::KbUp     then @buttons_pushed.push(:up)
    when Gosu::KbDown   then @buttons_pushed.push(:down)
    when Gosu::KbLeft   then @buttons_pushed.push(:left)
    when Gosu::KbRight  then @buttons_pushed.push(:right)
    when Gosu::KbEscape then toggle_pause
    when Gosu::KbQ      then close if @paused
    end
  end

  def button_up(id)
    case id
    when Gosu::KbUp    then @buttons_pushed.delete(:up)
    when Gosu::KbDown  then @buttons_pushed.delete(:down)
    when Gosu::KbLeft  then @buttons_pushed.delete(:left)
    when Gosu::KbRight then @buttons_pushed.delete(:right)
    end
  end

  private

  def toggle_pause
    if @paused
      @paused = false
    else
      @paused = true
    end
  end

end
