# frozen_string_literal: true

require_relative 'robot'
require_relative 'table'
require_relative 'helpers/command_parser_helper'
require_relative 'errors/exceptions'
# ToyRobotController module and main entry of the program
module ToyRobotController
  class << self
    attr_accessor :robot, :commands
    include CommandParserHelper

    def init(commands_stream, split_using = /\n/, table_size = 5)
      raise Exceptions::InvalidOrEmptyCommands if commands_stream.strip == ''

      @commands_stream = commands_stream
      @split_using = split_using
      @table = Table.new(table_size, table_size)
      @robot = Robot.new(@table)
      @commands = []
      populate_commands
    end

    def report(_format = 'console')
      @robot.to_s
    end

    def execute_commands
      raise Exceptions::NoValidCommandsFound if @commands.size.zero?
      raise Exceptions::PlaceCommandNotFound if @commands.select { |c| c.type == 'PLACE' }.size.zero?

      @commands.each { |command| send_command_to_robot(command) }
    end

    private

    def send_command_to_robot(command)
      case command.type
      when 'PLACE'
        @robot.place(command.value[0].to_i, command.value[1].to_i, command.value[2])
      when 'MOVE', 'RIGHT', 'LEFT', 'REPORT'
        @robot.send(command.type.downcase)
      end
    rescue Exceptions::RobotIsNotPlaced
    rescue Exceptions::TableOutOfBound
    end

    def populate_commands
      @commands_stream.split(@split_using).each do |command|
        current_command = parse_command(command)
        @commands << current_command unless current_command.nil?
      end
    end
  end
end
