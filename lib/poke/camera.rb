module Poke
  # A Camera object provides a viewport to the game window. It allows a player
  # character to move in an area of greater size than the window and still let
  # the user see the movement of the character on the screen.
  class Camera

    # Params required at initialization.
    PARAMS_REQUIRED = [:window, :player]

    # Creates a Camera object.
    #
    # params - The Hash of Symbol options.
    #   :player - The Player object that the Camera is tracking.
    #
    # Returns a Camera object.
    def initialize(params = {})
      @window = params[:window]
      @player = params[:player]
      @x, @y  = 0
    end

    # Fetches the Player's current location and updates the camera as the
    # inverse of that location.
    def update
      get_x
      get_y
    end

    def get_x
      @x = [[@player.x - 224, 0].max, @current_grid.width * 32 - 480].min
    end

    def get_y
      @y = [[@player.y - 160, 0].max, @current_grid.width * 32 - 320].min
    end

  end

end
