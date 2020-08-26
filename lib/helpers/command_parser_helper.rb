# frozen_string_literal: true

require_relative '../constants/application_constants'
require_relative 'command_helper'
# CommandParserHelper module
module CommandParserHelper
  include CommandHelper

  def parse_command(command)
    type_of_command = command_type(command)
    return if type_of_command.nil?
    return if type_of_command == PLACE && a_valid_place_command?(command) == false

    command_object(type_of_command, command_value(command))
  end

  private

  def command_value(command)
    return split_place_command(command) if place_command_and_valid?(command)

    command
  end

  def command_object(type, value, status = '', error = '')
    Struct.new(:type, :value, :status, :error).new(type, value, status, error)
  end

  def place_command_and_valid?(command)
    command_type(command) == PLACE && a_valid_place_command?(command)
  end
end
