# frozen_string_literal: true

DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
COMMANDS = %w[MOVE LEFT RIGHT REPORT PLACE].freeze
PLACE = COMMANDS.last.freeze
PLACE_COMMAND_PATTERN = Regexp.new(/#{PLACE}\s*(\d+)\s*,\s*(\d+)\s*,\s*(#{DIRECTIONS.join('|')})\s*$/)
