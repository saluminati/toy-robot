# frozen_string_literal: true

# RobotHelper module
module RobotHelper
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  COMMANDS = %w[MOVE LEFT RIGHT REPORT PLACE].freeze

  def directions
    DIRECTIONS
  end

  def commands
    COMMANDS
  end

  def a_valid_command?(command)
    commands.include? command
  end

  def a_valid_place_command?(command)
    return false if command.match(/^(PLACE+)/i).nil?

    place_commands = command.sub('PLACE', '').delete(' ').strip.split(',')
    return false unless place_commands.size == 3
    return false unless number?(place_commands[0])
    return false unless number?(place_commands[1])
    return false unless valid_direction?(place_commands.last)

    true
  end

  def valid_direction?(direction)
    directions.include? direction
  end

  def number?(str)
    return true unless str.match(/^[0-9]+$/).nil?

    false
  end

  def contains_place_command?(command)
    command.include? 'PLACE'
  end

  def calculate_potential_movement(facing)
    case facing
    when 'NORTH'
      { x: nil, y: 1 }
    when 'WEST'
      { x: -1, y: nil }
    when 'SOUTH'
      { x: nil, y: -1 }
    when 'EAST'
      { x: 1, y: nil }
    end
  end
end
