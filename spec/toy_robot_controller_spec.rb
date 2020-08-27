# frozen_string_literal: true

describe ToyRobotController do
  let(:controller) { described_class }

  describe '.init' do
    it 'will instanciate the robot' do
      controller.init("PLACE 0,0,NORTH\nMOVE\nREPORT\n")
      expect(controller.robot).to be_an_instance_of(ToyRobot::Robot)
    end

    it 'will populate the commands with valid commands only' do
      controller.init("PLACE 0,0,NORTH\nMOVE\nREPORT\nRANDOM Command")
      expect(controller.commands.map(&:value)).to match_array([%w[0 0 NORTH], 'MOVE', 'REPORT'])
    end
    context 'when commands are empty string' do
      it 'will raise InvalidOrEmptyCommands exception' do
        expect { controller.init('') }.to raise_error(Command::InvalidOrEmptyCommands)
      end
    end
  end

  describe '.execute_commands' do
    context 'when all commands are invalid' do
      it 'will raise NoValidCommandsFound exception' do
        controller.init("RANDOM Command\nadfadfadf\nadfrtrett")
        expect { controller.execute_commands }.to raise_error(Command::NoValidCommandsFound)
      end
    end

    context 'when PLACE command is not provided' do
      it 'will raise PlaceCommandNotFound exception' do
        controller.init("MOVE\nMOVE\nLEFT\nMOVE\nREPORT")
        expect { controller.execute_commands }.to raise_error(Command::PlaceCommandNotFound)
      end
      it 'will raise PlaceCommandNotFound exception with a PLACE command without X,Y,Facing' do
        controller.init("PLACE\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT")
        expect { controller.execute_commands }.to raise_error(Command::PlaceCommandNotFound)
      end
    end
  end

  describe '.report' do
    context 'when command sequence is PLACE 0,0,NORTH\nMOVE\nREPORT\n' do
      it 'will move the robot to 0,1,NORTH' do
        controller.init("PLACE 0,0,NORTH\nMOVE\nREPORT\n")
        controller.execute_commands
        expect(controller.report).to eq('0,1,NORTH')
      end
    end

    context 'when command sequence is PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT' do
      it 'will move the robot to 3,3,NORTH' do
        controller.init("PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT")
        controller.execute_commands
        expect(controller.report).to eq('3,3,NORTH')
      end
    end
    context 'when command sequence is PLACE 1,2,WEST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT' do
      it 'will move the robot to 0,1,SOUTH' do
        controller.init("PLACE 1,2,WEST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT")
        controller.execute_commands
        expect(controller.report).to eq('0,1,SOUTH')
      end
    end

    context 'when command sequence contains only PLACE command' do
      it 'will report where the robot was PLACED' do
        controller.init('PLACE 0,0,SOUTH')
        controller.execute_commands
        expect(controller.report).to eq('0,0,SOUTH')
      end
    end
    context 'when PLACE command is not provided' do
      it 'will raise RobotIsNotPlaced exception' do
        controller.init("MOVE\nMOVE\nLEFT\nMOVE\nREPORT")
        expect { controller.report }.to raise_error(ToyRobot::RobotIsNotPlaced)
      end
    end
  end
end
