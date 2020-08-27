# frozen_string_literal: true

module Command
  class InvalidOrEmptyCommands < StandardError; end
  class InvalidCommandStreamType < StandardError; end
  class InvalidCommandType < StandardError; end
  class NoValidCommandsFound < StandardError; end
  class PlaceCommandNotFound < StandardError; end
  class EmptyLocationProvided < StandardError; end
  class FormatNotSupported < StandardError; end
  class SourceNotSupported < StandardError; end
end
