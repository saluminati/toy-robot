# frozen_string_literal: true

module Command
  class InvalidOrEmptyCommands < StandardError; end
  class NoValidCommandsFound < StandardError; end
  class PlaceCommandNotFound < StandardError; end
end
