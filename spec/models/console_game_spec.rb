require 'spec_helper'

RSpec.describe ConsoleGame do
  let(:console_game) { described_class.new }
  let(:name) { 'Benny' }
  let(:difficulty) { 'hell' }
  let(:invalid_guess) { '123dd' }
  let(:valid_guess) { '1234' }

  describe 'create game user' do
    before do
      allow(console_game).to receive(:gets).and_return('a', name)
      console_game.create_user
    end

    it 'rescue error with message' do
      expect { console_game.create_user }.not_to raise_error
    end

    it 'with error message' do
      expect { console_game.create_user }.to output {
                                               include Codebreaker::ValidationHelper::NAME_SIZE
                                             }.to_stdout
    end

    it 'game creation' do
      expect { console_game.create_user }.to output { include I18n.t(:user_registration) }.to_stdout
    end

    it 'with correct difficulty' do
      expect(console_game.game.user.name).to eq(name)
    end
  end

  describe 'create game difficulty' do
    before do
      allow(console_game).to receive(:gets).and_return('unknown', difficulty)
      console_game.create_difficulty
    end

    it 'rescue error with message' do
      expect { console_game.create_difficulty }.not_to raise_error
    end

    it 'with error message' do
      expect { console_game.create_difficulty }.to output {
                                                     include Codebreaker::ValidationHelper::INCORRECT_DIFFICULTY
                                                   }.to_stdout
    end

    it 'game creation' do
      expect { console_game.create_difficulty }.to output { include I18n.t(:choose_level) }.to_stdout
    end

    it 'with correct difficulty' do
      expect(console_game.game.difficulty.type).to eq(difficulty)
    end
  end

  describe 'filter user input' do
    before { game_init_and_set_values }

    it 'take a hint' do
      expect(console_game.send(:filter_user_input,
                               Codebreaker::Game::HINT.to_s)[:status]).to eq(Codebreaker::Game::HINT)
    end

    it 'return response from Codebreaker gem' do
      expect(console_game.send(:filter_user_input, valid_guess)[:status]).to eq(Codebreaker::Game::OK)
    end
  end

  describe 'recieve exit' do
    before { allow(console_game).to receive(:exit) }

    it { expect(console_game.send(:filter_user_input, Constants::EXIT)).to eq(nil) }

    it {
      expect { console_game.send(:filter_user_input, Constants::EXIT) }.to output {
                                                                             include I18n.t(:game_exit)
                                                                           }.to_stdout
    }
  end

  describe 'run' do
    before do
      game_init_and_set_values
      allow(console_game).to receive(:gets).exactly(6).times.and_return(invalid_guess, valid_guess)
    end

    it { expect { console_game.run }.to output { include I18n.t(:input_guess) }.to_stdout }
    it { expect { console_game.run }.not_to raise_error }
  end

  def game_init_and_set_values
    allow(console_game).to receive(:gets).and_return(name, difficulty)
    console_game.create_user
    console_game.create_difficulty
  end
end
