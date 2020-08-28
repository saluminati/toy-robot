# frozen_string_literal: true

require_relative '../errors/command'
# CommandSetLoader is there to read commands from file locally for now
module CommandSetLoader
  class << self
    # @todo Add support to load file remotely and support for different formats such as JSON
    # @param location [String] location of the file containig commands
    # @param source [String]
    # @param format [String]
    # @raise [Command::FormatNotSupported] if format is not set to text
    # @raise [Command::SourceNotSupported] if source is not set to file
    # @raise [Command::EmptyLocationProvided] location is empty
    def read_commands(location = '', source = 'file', format = 'text')
      raise Command::FormatNotSupported, 'Only text format is supported' unless format == 'text'
      raise Command::SourceNotSupported, 'Only file as a source is supported' unless source == 'file'
      raise Command::EmptyLocationProvided if location.strip == ''

      @location = location
      read_from_file
    end

    private

    # reading commands from file and return Array of commands
    def read_from_file
      commands = []
      File.readlines(@location).each { |line| commands << line.strip }
      commands
    end
  end
end
