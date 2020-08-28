# frozen_string_literal: true

# contains ToyRobot related error classes
module ToyRobot
  class InvalidFacing < StandardError; end
  class RobotIsNotPlaced < StandardError; end
end
