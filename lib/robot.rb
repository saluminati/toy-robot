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
    @x = 0
    @y = 0
    @facing = 'NORTH'
  end

  def place(x, y, facing)
    return if @placed
    raise Exceptions::TableIsNotSet if @table.nil?
    raise Exceptions::TableOutOfBound unless @table.can_be_placed?(x, y)
    raise Exceptions::InvalidFacing unless DIRECTIONS.include?(facing)

    @x = x
    @y = y
    @facing = facing
    @placed = true
  end

  def left
    check_pre_conditions
    @facing = next_facing('left')
  end

  def right
    check_pre_conditions
    @facing = next_facing('right')
  end

  def move
    check_pre_conditions
    result = calculate_potential_movement(facing)

    x_should_be = result[:x].nil? ? @x : (@x + result[:x])
    y_should_be = result[:y].nil? ? @y : (@y + result[:y])

    raise Exceptions::TableOutOfBound unless @table.can_be_placed?(x_should_be, y_should_be)

    @x = x_should_be
    @y = y_should_be
  end

  def report(format = 'console')
    case format
    when 'console'
      to_s
    else
      { x: @x, y: @y, facing: @facing }
    end
  end

  def to_s
    "#{@x},#{@y},#{@facing}"
  end

  private

  def next_facing(arrow)
    return DIRECTIONS.last if @facing == DIRECTIONS.first && arrow == 'left'
    return DIRECTIONS.first if @facing == DIRECTIONS.last && arrow == 'right'

    increment_factor = arrow == 'left' ? -1 : 1
    new_index = DIRECTIONS.index(@facing) + increment_factor
    DIRECTIONS[new_index]
  end

  def check_pre_conditions
    raise Exceptions::TableIsNotSet if @table.nil?
    raise Exceptions::RobotIsNotPlaced unless @placed
  end
end
