# frozen_string_literal: true

describe RobotHelper do
  include RobotHelper

  describe '#valid_place_command?' do
    context 'when PLACE command is invalid' do
      it { expect(a_valid_place_command?('RANDOM')).to eq(false) }
      it { expect(a_valid_place_command?('A, B, PLACE, Y')).to eq(false) }
      it { expect(a_valid_place_command?('A, PLACE,B, Y')).to eq(false) }
      it { expect(a_valid_place_command?('A, B, PLACE, Y')).to eq(false) }
      it { expect(a_valid_place_command?('PLACE')).to eq(false) }
      it { expect(a_valid_place_command?('PLACE A, B')).to eq(false) }
      it { expect(a_valid_place_command?('PLACE A, B, F, G')).to eq(false) }
      it { expect(a_valid_place_command?('PLACE A, B, Y')).to eq(false) }
      it { expect(a_valid_place_command?('PLACE A, 0, Y')).to eq(false) }
      it { expect(a_valid_place_command?('PLACE 0, B, Y')).to eq(false) }
      it { expect(a_valid_place_command?('PLACE 0, 0, Y')).to eq(false) }
    end
  end

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

  describe '#valid_direction?' do
  end
end
