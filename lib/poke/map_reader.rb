module Poke
  # A MapReader object provides an engine for parsing and reading an ASCII map
  # file, and can provide various outputs for usage by other game objects.
  # e.g. A map file may be thus:
  #
  #   VV..gg
  #   ..VVgg
  #   ..VV..
  #
  # in a plain-text file (such as "map.txt").
  class MapReader

    # Creates an array of strings corresponding to the lines of the file passed in
    # as an argument. Useful for traversing a map using Y-then-X notation, e.g.
    # @map_in_columns[y][x].
    #
    # file - A String containing the path to the file to be converted.
    #
    # Examples
    #
    #   get_array_of_lines_from_file("map.txt")
    #   # => ["VV..gg", "..VVgg", "..VV.."]
    #
    # Returns an Array of Strings.
    def get_array_of_lines_from_file(file)
      File.readlines(file).map { |line| line.chomp }
    end

    # Creates an array of strings corresponding to the columns of the file passed
    # in as an argument. It will remove any empty lines and any hash keys. Useful
    # for traversing a map using X-then-Y notation, e.g. @map_in_columns[x][y].
    #
    # file - A String containing the path to the file to be converted.
    #
    # Examples
    #
    #   get_array_of_columns_from_file("map.txt")
    #   # => ["V..", "V..", ".VV", ".VV", "gg.", "gg."]
    #
    # Returns an Array of Strings.
    def get_array_of_columns_from_file(file)
      lines = get_array_of_lines_from_file(file)

      rx = /\{[^}]+\}/i
      lines.delete_if { |e| rx.match e }
      lines.delete("")

      width = lines[0].size
      height = lines.size

      columns = Array.new(width, '')

      lines.each do |line|
        width.times do |x|
          columns[x] += line[x]
        end
      end

      columns
    end

    # Gets the width of a lines Array. Width corresponds to the amount of
    # characters in each String element.
    #
    # lines - An Array of Strings, corresponding to lines in a map file.
    #
    # Returns a Fixnum.
    def get_width_for_lines(lines)
      lines[0].size
    end

    # Gets the height of a lines Array. Height corresponds to the amount of
    # elements in the Array.
    #
    # lines - An Array of Strings, corresponding to lines in a map file.
    #
    # Returns a Fixnum.
    def get_height_for_lines(lines)
      lines.size
    end

    # Gets the width of a columns Array. Width corresponds to the amount of
    # elements in the Array.
    #
    # columns - An Array of Strings, corresponding to columns in a map file.
    #
    # Returns a Fixnum.
    def get_width_for_columns(columns)
      columns.size
    end

    # Gets the height of a columns Array. Height corresponds to the amount of
    # characters in each String element.
    #
    # columns - An Array of Strings, corresponding to columns in a map file.
    #
    # Returns a Fixnum.
    def get_height_for_columns(columns)
      columns[0].size
    end

    # Iterates over each individual character in an array of lines, performing the
    # passed block on each element.
    #
    # lines - An Array of Strings, corresponding to lines in a map file.
    #
    # Yields two Fixnum.
    #
    # Examples
    #
    #   iterate_over_each_character_in_array_of_lines(@map_in_lines) do |y, x|
    #     if @map_in_lines[y][x] == "V"
    #       print "V!"
    #     end
    #   end
    #   # => V! V! V! V! V! V! V! V!
    #
    # Returns nothing.
    def iterate_over_each_character_in_array_of_lines(lines)
      get_height_for_lines(lines).times do |y|
        get_width_for_lines(lines).times do |x|
          yield(y, x)
        end
      end
    end

    # Searches an Array of lines for an element that matches the pattern of a
    # Hash. It extracts the String then deletes the element and any blank lines.
    #
    # lines - An Array of Strings, corresponding to lines in a map file.
    #
    # Returns a Hash, which is a Map-image key.
    def extract_map_key(lines)
      rx = /\{[^}]+\}/i
      map_key_index = lines.index { |i| rx.match i }

      map_key = eval(lines[map_key_index])

      lines.delete_at(map_key_index)
      lines.delete('')

      map_key
    end

  end
end
