
require_relative '../lib/player'
require_relative '../lib/board'

describe Player do

  describe '#initialize' do
    subject(:player1) {described_class.new('Andres')}
    subject(:player2) {described_class.new('Joshua')}

    context 'When the players are initialized' do

      it 'Initialize the first player with name' do
        name = player1.name
        expect(name).to eq 'Andres'
      end

      it 'Initialize the second player with name' do
        name = player2.name
        expect(name).to eq 'Joshua'
      end

      context "the symbol to the first player" do
        before do
          Player.class_variable_set(:@@player, 0)
        end

        it 'is assign as: 🔵' do
          symbol = player1.symbol
          expect(symbol).to eq("\u{1F535}")
        end
      end

      context "the symbol to the second player" do
        before do
          Player.class_variable_set(:@@player, 1)
        end

        it 'is assign as: 🔴' do
          symbol = player1.symbol
          expect(symbol).to eq("\u{1F534}")
        end
      end
    end
  end
end

describe Board do
  
end
