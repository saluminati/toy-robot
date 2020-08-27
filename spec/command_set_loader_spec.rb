# frozen_string_literal: true

describe CommandSetLoader do
  include CommandSetLoader

  describe '#read_commands' do
    it 'will load the commands from test1.txt file and return array of commands' do
      commands = read_commands('./test_data/test1.txt')
      expect(commands).to match_array(['PLACE 0,0,NORTH', 'MOVE', 'REPORT'])
    end

    it 'will load the commands from test2.txt file and return array of commands' do
      commands = read_commands('./test_data/test2.txt')
      expect(commands).to match_array(['PLACE 0,0,NORTH', 'LEFT', 'REPORT'])
    end

    it 'will load the commands from test3.txt file and return array of commands' do
      commands = read_commands('./test_data/test3.txt')
      expect(commands).to match_array(['PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE', 'REPORT'])
    end

    it 'will return SourceNotSupported exception if source is not file' do
      expect do
        read_commands('./test_data/test3.txt', 'remote')
      end.to raise_error(Command::SourceNotSupported)
    end

    it 'will return FormatNotSupported exception if source is not text' do
      expect do
        read_commands('./test_data/test3.txt', 'file', 'json')
      end.to raise_error(Command::FormatNotSupported)
    end
  end
end
