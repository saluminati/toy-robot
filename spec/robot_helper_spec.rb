# frozen_string_literal: true

describe RobotHelper do
  include RobotHelper

  describe '#calculate_potential_movement' do
    context 'when facing NORTH' do
      it 'should do one step positive in y direction' do
        result = calculate_potential_movement('NORTH')
        expect(result[:y]).to eq(1)
      end
    end

    context 'when facing WEST' do
      it 'should do one step positive in y direction' do
        result = calculate_potential_movement('WEST')
        expect(result[:x]).to eq(-1)
      end
    end

    context 'when facing SOUTH' do
      it 'should do one step positive in y direction' do
        result = calculate_potential_movement('SOUTH')
        expect(result[:y]).to eq(-1)
      end
    end

    context 'when facing EAST' do
      it 'should do one step positive in y direction' do
        result = calculate_potential_movement('EAST')
        expect(result[:x]).to eq(1)
      end
    end
  end
end
