
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

      context "the token to the first player" do
        before do
          Player.class_variable_set(:@@player, 0)
        end

        it 'is assign as: 🔵' do
          token = player1.token
          expect(token).to eq("\u{1F535}")
        end
      end

      context "the token to the second player" do
        before do
          Player.class_variable_set(:@@player, 1)
        end

        it 'is assign as: 🔴' do
          token = player1.token
          expect(token).to eq("\u{1F534}")
        end
      end
    end
  end
end

describe Board do

  describe "#initialize" do
    subject(:initial_board) {described_class.new}

    context "when the board is initialized" do

      it "has 6 rows" do
        columns = initial_board.board_array
        expect(columns.size).to eq 6
      end

      it "has 7 columns" do
        rows = initial_board.board_array[0]
        expect(rows.size).to eq 7
      end
    end
  end

  describe "#column_full?" do
    subject(:column_check) {described_class.new}

    context "when the board is empty" do
      it "column one is empty" do
        full = column_check.column_full?(1)

        expect(full).to be true
      end

      it "returns false when column number is less than 1" do
        full = column_check.column_full?(0)

        expect(full).to be false
      end
    end
  end

  describe "#available_row" do
    subject(:row_check) {described_class.new}

    context "when the board is empty" do

      before do
        Board.instance_variable_set(:@board_array, Array.new(5, (Array.new(7, "\u{1F518}"))).append(["\u{1F535}","\u{1F535}","\u{1F535}","\u{1F535}","\u{1F535}","\u{1F535}","\u{1F535}"]))
      end

      it "returns five as the available row" do
        row = row_check.available_row(1)
        expect(row).to be 5
      end



    end
  end
end
