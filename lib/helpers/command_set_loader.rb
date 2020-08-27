# frozen_string_literal: true

require_relative '../errors/command'
# CommandSetLoader module
module CommandSetLoader
  def read_commands(location = '', source = 'file', format = 'text')
    raise Command::FormatNotSupported, 'Only text format is supported' unless format == 'text'
    raise Command::SourceNotSupported, 'Only file as a source is supported' unless source == 'file'
    raise Command::EmptyLocationProvided if location.strip == ''

    @location = location
    read_from_file
  end

  private

  def read_from_file
    commands = []
    File.readlines(@location).each { |line| commands << line.strip }
    commands
  end
end
