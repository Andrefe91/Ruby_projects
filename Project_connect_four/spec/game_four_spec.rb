
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/game_four'

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

    context "when need to check the state of a column" do

      it "returns five as the available row with empty column" do
        row = row_check.available_row(1)
        expect(row).to be 5
      end

      it "returns four when the bottom is unavailable" do
        row_check.board_array[5][0] = "\u{1F535}"
        row = row_check.available_row(1)
        expect(row).to be 4
      end


    end
  end

  describe "#add_to_column" do
    context "When a player adds a token to the board" do
      subject(:add_token) {described_class.new}

      it "returns false if the column number is less than 1" do
        expect(add_token.add_to_column(0,"\u{1F535}")).to be false
      end

      it "returns true if the token was added successfully" do
        adds = add_token.add_to_column(1, "\u{1F535}")
        expect(adds).to be true
      end

      it "adds the token to the selected column" do
        add_token.add_to_column(1, "\u{1F535}")
        in_array = add_token.board_array[5][0]

        expect(in_array).to eq("\u{1F535}")
      end

    end
  end
end

describe Game_four do
  subject(:game) {described_class.new}

  describe "#require_players" do
    context "When the two players are registered" do
      before do
        player1_name = "Andres"
        player2_name = "Joshua"

        allow(game).to receive(:gets).and_return(player1_name, player2_name)
        game.require_players
      end

      it "save the names of both players" do
        player1 = game.player1.name
        player2 = game.player2.name

        expect(player1).to eq "Andres"
        expect(player2).to eq "Joshua"
      end
    end
  end
end
