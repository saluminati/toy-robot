# frozen_string_literal: true

# module Surface
module Surface
  # TableInterface to valid can_be_placed?(_x, _y) implemented by Table
  module TableInterface
    def can_be_placed?(_x, _y)
      raise 'Not implemented'
    end
  end
end
