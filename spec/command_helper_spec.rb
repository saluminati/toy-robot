# frozen_string_literal: true

describe CommandHelper do
  include CommandHelper

  describe '#command_type' do
    it { expect(command_type('MOVE')).to eq('MOVE') }
    it { expect(command_type('LEFT')).to eq('LEFT') }
    it { expect(command_type('RIGHT')).to eq('RIGHT') }
    it { expect(command_type('REPORT')).to eq('REPORT') }
    it { expect(command_type('SOMETHING')).to eq(nil) }
    it { expect(command_type('PLACE 0, 0, NORTH')).to eq('PLACE') }
    it { expect(command_type('PLACE')).to eq('PLACE') }
    it { expect(command_type(nil)).to eq(nil) }
  end
  
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

  describe '#split_place_command' do
    context 'when the PLACE command is valid as per PLACE_COMMAND_PATTERN' do
      it { expect(split_place_command('PLACE 0, 0, NORTH')).to match_array(['0', '0', 'NORTH']) }
      it { expect(split_place_command('PLACE 20, 0, NORTH')).to match_array(['20', '0', 'NORTH']) }
      it { expect(split_place_command('PLACE 0, 0, WEST')).to match_array(['0', '0', 'WEST']) }
      it { expect(split_place_command('PLACE 0, 0, SOUTH')).to match_array(['0', '0', 'SOUTH']) }
      it { expect(split_place_command('PLACE 100, 0, EAST')).to match_array(['100', '0', 'EAST']) }
    end

    context 'when the PLACE command is not according to the PLACE_COMMAND_PATTERN' do
      it { expect(split_place_command('PLACE 0, 0, Y')).to eq(nil) }
      it { expect(split_place_command('PLACE A, 0, NORTH')).to eq(nil) }
      it { expect(split_place_command('PLACE B, 0, SOUTH')).to eq(nil) }
    end
  end
end
