# frozen_string_literal: true

require_relative '../constants/application_constants'
require_relative 'command_helper'

# CommandParserHelper is just parsing the command and return a command Struct
module CommandParserHelper
  include CommandHelper

  # it the provided command is valid, it will return a Struct with
  # with type, value, status, error attributes
  #
  # type represents the type of command such as PLACE, MOVE, REPORT, LEFT, RIGHT
  #
  # value represents the value it holds such value will be X,Y,F for PLACE command
  #
  # status and error attributes are set to empty in the start
  # @param command [String]
  # @return [Struct]
  def parse_command(command)
    type_of_command = command_type(command)
    return if type_of_command.nil?
    return if type_of_command == PLACE && a_valid_place_command?(command) == false

    command_object(type_of_command, command_value(command))
  end

  private

  # returns the value of a comamnd
  def command_value(command)
    return split_place_command(command) if place_command_and_valid?(command)

    command
  end

  # return command Struct
  def command_object(type, value, status = '', error = '')
    Struct.new(:type, :value, :status, :error).new(type, value, status, error)
  end

  # check if it is a PLACE command and valid also
  def place_command_and_valid?(command)
    command_type(command) == PLACE && a_valid_place_command?(command)
  end
end
