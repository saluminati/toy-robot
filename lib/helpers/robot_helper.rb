# frozen_string_literal: true

require_relative '../constants/application_constants'
# RobotHelper module
module RobotHelper
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
