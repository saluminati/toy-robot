# frozen_string_literal: true

require_relative 'helpers/robot_helper'
require_relative 'errors/exceptions'
# Robot class
class Robot
  include RobotHelper
  attr_accessor :x, :y, :facing, :placed, :table

  def initialize(table = nil)
    @placed = false
    @table = table
  end

  def validate_command?(command)
    return a_valid_place_command?(command) if contains_place_command?(command)

    a_valid_command?(command)
  end

  def place_robot(x, y, facing)
    raise Exceptions::TableIsNotSet if @table.nil?
    raise Exceptions::TableOutOfBound unless @table.can_be_placed?(x, y)
    raise Exceptions::InvalidFacing unless valid_direction?(facing)

    @x = x
    @y = y
    @facing = facing
    @placed = true
  end

  def left
    if @facing == directions.first
      @facing = directions.last
    else
      @facing = directions[directions.index(@facing) - 1]
    end
  end

  def right
    if @facing == directions.last
      @facing = directions.first
    else
      @facing = directions[directions.index(@facing) + 1]
    end
  end

  def move
    raise Exceptions::TableIsNotSet if @table.nil?
    result = calculate_potential_movement(facing)

    x_should_be = result[:x].nil? ? @x : ( @x + result[:x] )
    y_should_be = result[:y].nil? ? @y : ( @y + result[:y] )
    
    raise Exceptions::TableOutOfBound unless @table.can_be_placed?(x_should_be, y_should_be)

    @x = x_should_be
    @y = y_should_be
  end
end
