# frozen_string_literal: true

# Robot class
class Robot
  attr_accessor :position, :placed
  VALID_DIRECTIONS = %w[NORTH SOUTH EAST WEST].freeze
  VALID_COMMANDS = %w[MOVE LEFT RIGHT REPORT PLACE].freeze

  def initialize
    @position = { x: 0, y: 0, facing: VALID_DIRECTIONS.first }
    @placed = false
  end

  def valid_command?(command)
    @current_command = command
    return validate_place_command? if place_command?

    validate_command?
  end

  private

  def validate_command?
    VALID_COMMANDS.include? @current_command
  end

  def validate_direction?(direction)
    VALID_DIRECTIONS.include? direction
  end

  def number?(str)
    return true unless str.match(/^[0-9]+$/).nil?

    false
  end

  def place_command?
    return true unless @current_command.match(/^(PLACE+)/i).nil?

    false
  end

  def validate_place_command?
    place_commands = @current_command.sub('PLACE', '').delete(' ').strip.split(',')
    return false unless place_commands.size == 3
    return false unless number?(place_commands[0])
    return false unless number?(place_commands[1])
    return false unless validate_direction?(place_commands.last)

    true
  end
end
