# frozen_string_literal: true

require_relative '../constants/application_constants'
# CommandHelper module
module CommandHelper
  def a_valid_place_command?(command) 
    return false if command.match(PLACE_COMMAND_PATTERN).nil?
    true
  end

  def split_place_command(place_command)
    result = place_command.match(PLACE_COMMAND_PATTERN)
    result.captures unless result.nil?
  end

  def command_type(command)
    return if command.nil?
    return PLACE if command.include? PLACE
    return command if COMMANDS.include? command
  end

  def directions
    DIRECTIONS
  end

  def commands
    COMMANDS
  end
end
