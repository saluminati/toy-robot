# frozen_string_literal: true

describe Robot do
  let(:robot) { described_class.new }
  let(:table) { Table.new }
  let(:robot_with_table) { described_class.new(table) }

  it 'should initialize and set the instance variables' do
    expect(robot.placed).to eq(false)
  end

  describe '#place_robot' do
    context 'when table size is 5x5 and x, y are within the table bounds along with valid facing position' do
      it 'will successfully place the robot onto the table' do
        robot_with_table.place_robot(0, 0, 'SOUTH')
        expect(robot_with_table.placed).to eq(true)
      end
    end

    context 'when facing value is not valid' do
      it 'will raise InvalidFacing Exception' do
        expect { robot_with_table.place_robot(0, 0, 'RANDOM') }.to raise_error(Exceptions::InvalidFacing)
      end
    end

    context 'when coordinates are out of bounds' do
      it 'will raise TableOutOfBound Exception' do
        expect { robot_with_table.place_robot(0, 50, 'SOUTH') }.to raise_error(Exceptions::TableOutOfBound)
      end
    end

    context 'when table is nil' do
      it 'will raise TableIsNotSet Exception' do
        robot_with_table.table = nil
        expect { robot_with_table.place_robot(0, 0, 'SOUTH') }.to raise_error(Exceptions::TableIsNotSet)
      end
    end
  end

  describe '#left' do
    context 'when robot is not placed on the table yet' do
      it 'raises RobotIsNotPlaced exception' do
        expect { robot_with_table.left }.to raise_error(Exceptions::RobotIsNotPlaced)
      end
    end

    context 'when table is not set' do
      it 'raises TableIsNotSet exception' do
        expect { robot.left }.to raise_error(Exceptions::TableIsNotSet)
      end
    end

    context 'when robot is facing NORTH' do
      it 'will rotate the robot towards WEST' do
        robot_with_table.place_robot(0, 0, 'NORTH')
        robot_with_table.left
        expect(robot_with_table.facing).to eq('WEST')
      end
    end

    context 'when robot is facing WEST' do
      it 'will rotate the robot towards SOUTH' do
        robot_with_table.place_robot(0, 0, 'WEST')
        robot_with_table.left
        expect(robot_with_table.facing).to eq('SOUTH')
      end
    end

    context 'when robot is facing SOUTH' do
      it 'will rotate the robot towards EAST' do
        robot_with_table.place_robot(0, 0, 'SOUTH')
        robot_with_table.left
        expect(robot_with_table.facing).to eq('EAST')
      end
    end

    context 'when robot is facing EAST' do
      it 'will rotate the robot towards NORTH' do
        robot_with_table.place_robot(0, 0, 'EAST')
        robot_with_table.left
        expect(robot_with_table.facing).to eq('NORTH')
      end
    end
  end

  describe '#right' do
    context 'when robot is not placed on the table yet' do
      it 'raises RobotIsNotPlaced exception' do
        expect { robot_with_table.right }.to raise_error(Exceptions::RobotIsNotPlaced)
      end
    end

    context 'when table is not set' do
      it 'raises TableIsNotSet exception' do
        expect { robot.right }.to raise_error(Exceptions::TableIsNotSet)
      end
    end

    context 'when robot is facing WEST' do
      it 'will rotate the robot towards NORTH' do
        robot_with_table.place_robot(0, 0, 'WEST')
        robot_with_table.right
        expect(robot_with_table.facing).to eq('NORTH')
      end
    end

    context 'when robot is facing NORTH' do
      it 'will rotate the robot towards EAST' do
        robot_with_table.place_robot(0, 0, 'NORTH')
        robot_with_table.right
        expect(robot_with_table.facing).to eq('EAST')
      end
    end

    context 'when robot is facing EAST' do
      it 'will rotate the robot towards SOUTH' do
        robot_with_table.place_robot(0, 0, 'EAST')
        robot_with_table.right
        expect(robot_with_table.facing).to eq('SOUTH')
      end
    end

    context 'when robot is facing SOUTH' do
      it 'will rotate the robot towards WEST' do
        robot_with_table.place_robot(0, 0, 'SOUTH')
        robot_with_table.right
        expect(robot_with_table.facing).to eq('WEST')
      end
    end
  end

  describe '#move' do
    context 'when the table is not set' do
      it 'raises TableIsNotSet exception' do
        expect { robot.move }.to raise_error(Exceptions::TableIsNotSet)
      end
    end

    context 'when the robot is not placed' do
      it 'raises TableIsNotSet exception' do
        expect { robot_with_table.move }.to raise_error(Exceptions::RobotIsNotPlaced)
      end
    end

    context 'when robot is placed at 0,0 NORTH' do
      it 'will result in 0, 1 NORTH' do
        robot_with_table.place_robot(0, 0, 'NORTH')
        robot_with_table.move
        expect(robot_with_table.x).to eq(0)
        expect(robot_with_table.y).to eq(1)
        expect(robot_with_table.facing).to eq('NORTH')
      end
    end

    context 'when robot is placed at 0,4 NORTH' do
      it 'raises TableOutOfBound exception' do
        robot_with_table.place_robot(0, 4, 'NORTH')
        expect { robot_with_table.move }.to raise_error(Exceptions::TableOutOfBound)
      end
    end
  end
end
