# frozen_string_literal: true

require_relative 'table_interface'
require_relative '../errors/table'
module Surface
  # Table class represents a square table of 5x5 by default
  # @todo Add functionality to add Obsturctions on Table
  class Table
    include TableInterface
    attr_accessor :rows, :columns, :grid

    # @param rows [Integer]
    # @param columns [Integer]
    def initialize(rows = 5, columns = 5)
      @grid = Array.new(rows) { Array.new(columns) { 0 } }
      @rows = rows
      @columns = columns
    end

    # validates if the x, y can be placed on to the table
    # @param x [Integer]
    # @param y [Integer]
    # @return [Boolean]
    def can_be_placed?(x, y)
      return false unless (0..(rows - 1)).include?(x)
      return false unless (0..(columns - 1)).include?(y)

      true
    end
  end
end
