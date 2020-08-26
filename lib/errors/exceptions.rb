# frozen_string_literal: true

module Exceptions
  class TableOutOfBound < StandardError; end
  class InvalidFacing < StandardError; end
  class TableIsNotSet < StandardError; end
  class RobotIsNotPlaced < StandardError; end
  class InvalidOrEmptyCommands < StandardError; end
  class NoValidCommandsFound < StandardError; end
  class PlaceCommandNotFound < StandardError; end
end
