# frozen_string_literal: true

describe Surface::Table do
  let(:table) { described_class.new }

  it 'should initialize and set the instance variables' do
    expect(table.rows).to eq(5)
    expect(table.columns).to eq(5)
  end

  describe '#can_be_placed?' do
    context 'when table is 5x5' do
      it { expect(table.can_be_placed?(4, 4)).to eq(true) }
      it { expect(table.can_be_placed?(0, 0)).to eq(true) }
      it { expect(table.can_be_placed?(4, 5)).to eq(false) }
      it { expect(table.can_be_placed?(5, 5)).to eq(false) }
      it { expect(table.can_be_placed?(-5, 5)).to eq(false) }
    end
  end
end
