# frozen_string_literal: true

require_relative 'toy_robot/robot'
require_relative 'surface/table'
require_relative 'helpers/command_parser_helper'
require_relative 'errors/command'

# ToyRobotController module which sets up the Robot, Table and execute commands provided
module ToyRobotController
  class << self
    include CommandParserHelper

    # This method is expecting [Array<String>] of commands such as ['PLACE 0,0,NORTH', 'MOVE', 'REPORT']
    # @param commands_stream [Array<String>]
    # @param table_size [Integer]
    #
    # @raise [Command::InvalidCommandStreamType] if the commands_stream is not of type Array
    #
    # @raise [Command::InvalidOrEmptyCommands] if the commands_stream array length is 0
    #
    # @raise [Command::InvalidCommandType] if the any of commands_stream element is not type String
    #
    # @raise [Command::NoValidCommandsFound] if the commands_stream array length is 0 or contains all invalid commands
    #
    # @raise [Command::PlaceCommandNotFound] if the commands_stream array does not contain a valid PLACE command
    def init(commands_stream, table_size = 5)
      validate_command_stream(commands_stream)

      @commands_stream = commands_stream
      @table = Surface::Table.new(table_size, table_size)
      @robot = ToyRobot::Robot.new(@table)
      @commands = []
      populate_commands
      execute_commands
    end

    # return [ToyRobot::Robot] if present
    # @return [ToyRobot::Robot]
    attr_reader :robot

    # return Array of commands if present
    #
    # example: <struct type="PLACE", value=["0", "0", "NORTH"], status="", error="">
    # @return [Array<Struct>]
    attr_reader :commands

    private

    # validate the populated commands and send each to the send_command_to_robot method
    def execute_commands
      raise Command::NoValidCommandsFound if @commands.size.zero?
      raise Command::PlaceCommandNotFound if @commands.select { |c| c.type == 'PLACE' }.size.zero?

      @commands.each { |command| send_command_to_robot(command) }
    end

    # based on command type, it call the appropriate method of Robot
    # if the command can not be executed by the Robot, it will update the status and error attributes
    # of command struct
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

    # checks the integrity of commands_stream Array
    def validate_command_stream(commands_stream)
      raise Command::InvalidCommandStreamType unless commands_stream.is_a?(Array)
      raise Command::InvalidOrEmptyCommands if commands_stream.size.zero?
      raise Command::InvalidCommandType unless commands_stream.all? { |i| i.is_a? String }
    end

    # filling the commands array with all the valid commands by parse_command method
    def populate_commands
      @commands_stream.each do |command|
        current_command = parse_command(command)
        @commands << current_command unless current_command.nil?
      end
    end
  end
end
