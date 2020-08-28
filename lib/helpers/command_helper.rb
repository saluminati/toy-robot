# frozen_string_literal: true

require_relative '../constants/application_constants'

# CommandHelper contains all the helper methods to valid integrity and type of a command
module CommandHelper
  # it will validate the provided command against the PLACE_COMMAND_PATTERN set in the application_contants
  # @retrun [Boolean]
  def a_valid_place_command?(command)
    return false if command.match(PLACE_COMMAND_PATTERN).nil?

    true
  end

  def split_place_command(place_command)
    result = place_command.match(PLACE_COMMAND_PATTERN)
    result&.captures
  end

  # it will return type of command such as PLACE, MOVE, LEFT, RIGHT, REPORT
  # @return [String]
  def command_type(command)
    return if command.nil?
    return PLACE if command.include? PLACE
    return command if COMMANDS.include? command
  end

  # return all directions array [NORTH EAST SOUTH WEST]
  # @return [Array]
  def directions
    DIRECTIONS
  end

  # return all valid commands array [MOVE LEFT RIGHT REPORT PLACE]
  # @return [Array]
  def commands
    COMMANDS
  end
end
