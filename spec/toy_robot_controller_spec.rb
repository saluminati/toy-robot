# frozen_string_literal: true

describe ToyRobotController do
  let(:controller) { described_class }

  describe '.init' do
    it 'will instanciate the robot' do
      comamnds_stream = ['PLACE 0,0,NORTH', 'MOVE', 'REPORT']
      controller.init(comamnds_stream)
      expect(controller.robot).to be_an_instance_of(ToyRobot::Robot)
    end

    it 'will populate the commands with valid commands only' do
      comamnds_stream = ['PLACE 0,0,NORTH', 'MOVE', 'REPORT', 'RANDOM Command']
      controller.init(comamnds_stream)
      expect(controller.commands.map(&:value)).to match_array([%w[0 0 NORTH], 'MOVE', 'REPORT'])
    end
    context 'when command steams type is not Array' do
      it 'will raise InvalidCommandStreamType exception' do
        expect { controller.init('') }.to raise_error(Command::InvalidCommandStreamType)
      end
    end

    context 'when command steams is empty' do
      it 'will raise InvalidOrEmptyCommands exception' do
        expect { controller.init([]) }.to raise_error(Command::InvalidOrEmptyCommands)
      end
    end

    context 'when command steams Array contains non String types' do
      it 'will raise InvalidOrEmptyCommands exception' do
        comamnds_stream = [1, 'PLACE 0,0,NORTH', 'REPORT']
        expect { controller.init(comamnds_stream) }.to raise_error(Command::InvalidCommandType)
      end
    end
    context 'when all commands are invalid' do
      it 'will raise NoValidCommandsFound exception' do
        comamnds_stream = ['RANDOM Command', 'adfadfadf', 'adfrtrett']
        expect { controller.init(comamnds_stream) }.to raise_error(Command::NoValidCommandsFound)
      end
    end

    it 'will ignore all commands before PLACE' do
      controller.init(['MOVE', 'REPORT', 'PLACE 1,1,NORTH', 'MOVE', 'REPORT'])
      expect(controller.commands.select { |c| c.status == 'ignored' }.size).to eq(2)
    end

    context 'when PLACE command is not provided' do
      it 'will raise PlaceCommandNotFound exception' do
        expect { controller.init(%w[MOVE MOVE LEFT MOVE REPORT]) }.to raise_error(Command::PlaceCommandNotFound)
      end
      it 'will raise PlaceCommandNotFound exception with a PLACE command without X,Y,Facing' do
        expect { controller.init(%w[PLACE MOVE MOVE LEFT MOVE REPORT]) }.to raise_error(Command::PlaceCommandNotFound)
      end
    end
  end

  describe '.report' do
    context 'when command sequence is PLACE 0,0,NORTH MOVE REPORT ' do
      it 'will move the robot to 0,1,NORTH' do
        controller.init(['PLACE 0,0,NORTH', 'MOVE', 'REPORT'])
        expect(controller.robot.report).to eq('0,1,NORTH')
      end
    end

    context 'when command sequence is PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT' do
      it 'will move the robot to 3,3,NORTH' do
        controller.init(['PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE', 'REPORT'])
        expect(controller.robot.report).to eq('3,3,NORTH')
      end
    end
    context 'when command sequence is PLACE 1,2,WEST MOVE MOVE LEFT MOVE REPORT' do
      it 'will move the robot to 0,1,SOUTH' do
        controller.init(['PLACE 1,2,WEST', 'MOVE', 'MOVE', 'LEFT', 'MOVE', 'REPORT'])
        expect(controller.robot.report).to eq('0,1,SOUTH')
      end
    end

    context 'when command sequence contains only PLACE command' do
      it 'will report where the robot was PLACED' do
        controller.init(['PLACE 0,0,SOUTH'])
        expect(controller.robot.report).to eq('0,0,SOUTH')
      end
    end
  end
end
