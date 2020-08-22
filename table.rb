# frozen_string_literal: true

require_relative 'helpers/robot_helper'
# Table class
class Table
  include RobotHelper

  attr_accessor :rows, :columns, :grid

  def initialize(rows = 5, columns = 5)
    @grid = Array.new(rows) { Array.new(columns) { 0 } }
    @rows = rows
    @columns = columns
  end

  def can_be_placed?(x, y)
    return false unless (0..(rows - 1)).include?(x)
    return false unless (0..(columns - 1)).include?(y)

    true
  end
end
