# frozen_string_literal: true

require_relative '../errors/command'
require_relative '../errors/robot'
module ToyRobot
  # Robot class represents our ToyRobot which be moving on to the table
  class Robot
    attr_accessor :x, :y, :facing, :placed, :table

    # this method will set the instance methods such as table, placed, x, y and facing of robot
    # @param table [Surface::Table]
    def initialize(table = nil)
      @placed = false
      @table = table
      @x = nil
      @y = nil
      @facing = nil
    end

    # This method will place the robot on the table as per provided coordinates
    # and direction it should be facing
    # @param x [Integer]
    # @param y [Integer]
    # @param facing [String]
    # @raise [Surface::TableIsNotSet] if the table is not set
    #
    # @raise [Surface::TableOutOfBound] if x or y will make the robot fall from the table
    #
    # @raise [Surface::InvalidFacing] if the facing value is other than [NORTH SOUTH EAST WEST]
    #
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

    # move the robot 90 degress counter clock wise
    #
    # example: if the robot was facing NORTH, it will be facing WEST after this method call
    # @raise [Surface::TableIsNotSet] if the table is not set
    # @raise [ToyRobot::RobotIsNotPlaced] if the robot is not placed
    def left
      check_pre_conditions
      @facing = next_facing('left')
    end

    # move the robot 90 degress  clock wise
    #
    # example: if the robot was facing EAST, it will be facing SOUTH after this method call
    # @raise [Surface::TableIsNotSet] if the table is not set
    # @raise [ToyRobot::RobotIsNotPlaced] if the robot is not placed
    def right
      check_pre_conditions
      @facing = next_facing('right')
    end

    # move the robot in the direct it is facing if possible
    #
    # @raise [Surface::TableOutOfBound] if the potential x or y will make the robot fall from the table
    # @raise [Surface::TableIsNotSet] if the table is not set
    # @raise [ToyRobot::RobotIsNotPlaced] if the robot is not placed
    def move
      check_pre_conditions
      result = calculate_potential_movement(facing)

      x_should_be = result[:x].nil? ? @x : (@x + result[:x])
      y_should_be = result[:y].nil? ? @y : (@y + result[:y])

      raise Surface::TableOutOfBound unless @table.can_be_placed?(x_should_be, y_should_be)

      @x = x_should_be
      @y = y_should_be
    end

    # @todo Add suppor for other formats such as JSON, XML, HTML etc
    # @param format [String] default value is console
    # @raise [ToyRobot::RobotIsNotPlaced] if the robot is not placed on to the table
    def report(format = 'console')
      raise ToyRobot::RobotIsNotPlaced unless @placed

      case format
      when 'console'
        to_s
      else
        { x: @x, y: @y, facing: @facing }
      end
    end

    # based on provided facing direction, which x or y coordinates should mutate
    #
    # *this method does not validate if the robot will fall from the table*
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

    # based on provided arrow value left/right
    # it determines the next direction of robot facing
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
