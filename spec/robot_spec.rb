# frozen_string_literal: true

describe Robot do
  let(:robot) { described_class.new }

  it 'should initialize and set the instance variables' do
    expect(robot.position).not_to be_empty
  end

  describe '#valid_command?' do
    it { expect(robot.valid_command?('MOVE')).to eq(true) }
    it { expect(robot.valid_command?('LEFT')).to eq(true) }
    it { expect(robot.valid_command?('RIGHT')).to eq(true) }
    it { expect(robot.valid_command?('REPORT')).to eq(true) }
    it { expect(robot.valid_command?('PLACE 0, 0, NORTH')).to eq(true) }
    it { expect(robot.valid_command?('PLACE 0, 0, SOUTH')).to eq(true) }
    it { expect(robot.valid_command?('PLACE 0, 0, EAST')).to eq(true) }
    it { expect(robot.valid_command?('PLACE 0, 0, WEST')).to eq(true) }
    it { expect(robot.valid_command?('SOMETHING')).to eq(false) }

    context 'when PLACE command is invalid' do
      it 'will not validate if the length of command is not equal to 4' do
        expect(robot.valid_command?('PLACE')).to eq(false)
        expect(robot.valid_command?('PLACE A, B')).to eq(false)
        expect(robot.valid_command?('PLACE A, B, F, G')).to eq(false)
      end

      it 'will not validate if PLACE is not the first parameter' do
        expect(robot.valid_command?('A, B, PLACE, Y')).to eq(false)
        expect(robot.valid_command?('A, PLACE,B, Y')).to eq(false)
        expect(robot.valid_command?('A, B, PLACE, Y')).to eq(false)
      end

      it 'will not validate if PLACE command coordinates are not integers' do
        expect(robot.valid_command?('PLACE A, B, Y')).to eq(false)
        expect(robot.valid_command?('PLACE A, 0, Y')).to eq(false)
        expect(robot.valid_command?('PLACE 0, B, Y')).to eq(false)
        expect(robot.valid_command?('PLACE 90, B, Y')).to eq(false)
      end

      it 'will not validate if the PLACE command has invalid FACING' do
        expect(robot.valid_command?('PLACE 0, 0, Y')).to eq(false)
      end
    end
  end
  
end
