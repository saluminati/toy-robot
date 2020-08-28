# frozen_string_literal: true

# Surface module is trying to set the rules interfaces type of surfaces such as TableInterface.
#
# in a nutshell a Table should include the *Surface:TableInterface* and override the can_be_placed? method
#
# if we want to add any other surface such as Benchtop, it will be a good
# practice to create a BenchtopInterface module with the method(s) represents it rules
module Surface
  # TableInterface to valid can_be_placed?(_x, _y) implemented by Table
  module TableInterface
    def can_be_placed?(_x, _y)
      raise 'Not implemented'
    end
  end
end
