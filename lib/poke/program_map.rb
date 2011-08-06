module Poke
  # +ProgramMap+ parses a map file and stores it as an Array, which contains
  # paths and initial positions for {Program} instances. It will instantiate the
  # programs as indicated by the map file.
  class ProgramMap

    include Poke::ReadMap

    # The parameters required at initialization.
    PARAMS_REQUIRED = [:map_file]

    # Creates a new +ProgramMap+.
    #
    # @param [Hash] params
    # @option params [String] :map_file a String containing the path to the map
    #   file, e.g. "media/map.txt".
    def initialize(params = {})
      Poke::Params.check_params(params, PARAMS_REQUIRED)

      @map_in_lines = get_array_of_lines_from_file(params[:map_file])
    end

    # Parses a map array for the upper-left and lower-right corners of each
    # separate path rectangle in the map. This indicates a new NPC and a new
    # path.
    #
    # @api private
    #
    # @return [Array] An array of array elements, each element containing the
    #   coordinates (in y,x notation) of the upper-left and lower-right corners
    #   of each path.
    def find_each_path_rectangle
    end

  end

end
