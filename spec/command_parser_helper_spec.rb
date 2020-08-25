# frozen_string_literal: true

describe CommandParserHelper do
  include CommandParserHelper

  describe '#parse_command' do
    let(:struct_blue_print) { { type: 'PLACE', value: ['0', '0', 'NORTH'], status: '', error: '' } }

    context 'when the command is a valid PLACE command' do
      it 'will return an onject containing type, value, status and error' do
        expect(parse_command('PLACE 0, 0, NORTH')).to have_attributes(struct_blue_print)
      end

      it { expect(parse_command('PLACE 0, 0, NORTH').type).to eq('PLACE') }
      it { expect(parse_command('PLACE 0, 1, NORTH').value).to match_array(['0', '1', 'NORTH']) }
      it { expect(parse_command('PLACE 0, 0, NORTH').status).to eq('') }
      it { expect(parse_command('PLACE 0, 0, NORTH').error).to eq('') }
    end

    context 'when any other valid command is provided' do
      it { expect(parse_command('RIGHT').type).to eq('RIGHT') }
      it { expect(parse_command('RIGHT').value).to eq('RIGHT') }
      it { expect(parse_command('LEFT').type).to eq('LEFT') }
      it { expect(parse_command('MOVE').type).to eq('MOVE') }
      it { expect(parse_command('REPORT').type).to eq('REPORT') }
    end

    context 'when an invalid command is provided' do
      it { expect(parse_command('REPORTME')).to eq(nil) }
      it { expect(parse_command('RIGHTT')).to eq(nil) }
      it { expect(parse_command('right')).to eq(nil) }
    end

    context 'when an invalid PLACE command is provided' do
      it { expect(parse_command('PLACE')).to eq(nil) }
      it { expect(parse_command('PLACE A, B')).to eq(nil) }
      it { expect(parse_command('PLACE A, B, F, G')).to eq(nil) }
      it { expect(parse_command('PLACE A, B, Y')).to eq(nil) }
      it { expect(parse_command('PLACE A, 0, Y')).to eq(nil) }
      it { expect(parse_command('PLACE 0, B, Y')).to eq(nil) }
      it { expect(parse_command('PLACE 0, 0, Y')).to eq(nil) }
    end
  end
end