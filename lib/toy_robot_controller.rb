# frozen_string_literal: true

require_relative 'toy_robot/robot'
require_relative 'surface/table'
require_relative 'helpers/command_parser_helper'
require_relative 'errors/command'
# ToyRobotController module and main entry of the program
module ToyRobotController
  class << self
    attr_accessor :robot, :commands
    include CommandParserHelper

    def init(commands_stream, table_size = 5)
      validate_command_stream(commands_stream)

      @commands_stream = commands_stream
      @table = Surface::Table.new(table_size, table_size)
      @robot = ToyRobot::Robot.new(@table)
      @commands = []
      populate_commands
    end

    def report(format = 'console')
      @robot.report(format)
    end

    def execute_commands
      raise Command::NoValidCommandsFound if @commands.size.zero?
      raise Command::PlaceCommandNotFound if @commands.select { |c| c.type == 'PLACE' }.size.zero?

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
    rescue ToyRobot::RobotIsNotPlaced, Surface::TableOutOfBound => e
      command.status = 'ignored'
      command.error = e.to_s
    end

    def validate_command_stream(commands_stream)
      raise Command::InvalidCommandStreamType unless commands_stream.is_a?(Array)
      raise Command::InvalidOrEmptyCommands if commands_stream.size.zero?
      raise Command::InvalidCommandType unless commands_stream.all? { |i| i.is_a? String }
    end

    def populate_commands
      @commands_stream.each do |command|
        current_command = parse_command(command)
        @commands << current_command unless current_command.nil?
      end
    end
  end
end
