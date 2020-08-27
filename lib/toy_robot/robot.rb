# frozen_string_literal: true

require_relative '../errors/command'
require_relative '../errors/robot'
module ToyRobot
  # Robot class
  class Robot
    attr_accessor :x, :y, :facing, :placed, :table

    def initialize(table = nil)
      @placed = false
      @table = table
      @x = nil
      @y = nil
      @facing = nil
    end

    def place(x, y, facing)
      return if @placed
      raise Surface::TableIsNotSet if @table.nil?
      raise Surface::TableOutOfBound unless @table.can_be_placed?(x, y)
      raise ToyRobot::InvalidFacing unless DIRECTIONS.include?(facing)

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

      raise Surface::TableOutOfBound unless @table.can_be_placed?(x_should_be, y_should_be)

      @x = x_should_be
      @y = y_should_be
    end

    def report(format = 'console')
      raise ToyRobot::RobotIsNotPlaced unless @placed

      case format
      when 'console'
        to_s
      else
        { x: @x, y: @y, facing: @facing }
      end
    end

    def calculate_potential_movement(facing)
      case facing
      when 'NORTH'
        { x: nil, y: 1 }
      when 'WEST'
        { x: -1, y: nil }
      when 'SOUTH'
        { x: nil, y: -1 }
      when 'EAST'
        { x: 1, y: nil }
      end
    end

    private

    def to_s
      "#{@x},#{@y},#{@facing}"
    end

    def next_facing(arrow)
      return DIRECTIONS.last if @facing == DIRECTIONS.first && arrow == 'left'
      return DIRECTIONS.first if @facing == DIRECTIONS.last && arrow == 'right'

      increment_factor = arrow == 'left' ? -1 : 1
      new_index = DIRECTIONS.index(@facing) + increment_factor
      DIRECTIONS[new_index]
    end

    def check_pre_conditions
      raise Surface::TableIsNotSet if @table.nil?
      raise ToyRobot::RobotIsNotPlaced unless @placed
    end
  end
end
