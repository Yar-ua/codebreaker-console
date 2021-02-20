require 'spec_helper'

RSpec.describe ConsoleGame do
  let(:console_game) { described_class.new }
  let(:name) { 'John Sina' }
  let(:difficulty) { 'hard' }

  describe 'have nil values when just created' do
    it { expect(console_game.user).to eq(nil) }
    it { expect(console_game.game).to eq(nil) }
  end

  describe 'set user value through' do
    before do
      allow(console_game).to receive(:gets).and_return('1', name)
      console_game.set_user
    end

    it 'rescue error' do
      expect { console_game.set_user }.not_to raise_error
    end

    it 'rescue with message' do
      expect { console_game.set_user }.to output { include ConsoleInterface::USER_ERROR }.to_stdout
    end

    it 'user registration' do
      expect { console_game.set_user }.to output { include I18n.t(:user_registration) }.to_stdout
    end

    it 'have name' do
      expect(console_game.user.name).to eq(name)
    end
  end

  describe 'set game and difficulty' do
    before do
      allow(console_game).to receive(:gets).and_return(Constants::UNKNOWN_INPUT, difficulty)
      console_game.set_game
    end

    it 'rescue error with message' do
      expect { console_game.set_game }.not_to raise_error
    end

    it 'with error message' do
      expect { console_game.set_game }.to output {
                                            include Codebreaker::ValidationHelper::INCORRECT_DIFFICULTY
                                          }.to_stdout
    end

    it 'game creation' do
      expect { console_game.set_game }.to output { include I18n.t(:choose_level) }.to_stdout
    end

    it 'with correct difficulty' do
      expect(console_game.game.difficulty).to eq(difficulty)
    end
  end

  describe 'filter user input' do
    before { game_init_and_set_values }

    it 'take a hint' do
      expect(console_game.send(:filter_user_input, Constants::HINT)[:status]).to eq(:hint)
    end

    it 'return response from Codebreaker gem' do
      expect(console_game.send(:filter_user_input, '1234')[:status]).to eq(:ok)
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
      allow(console_game).to receive(:gets).exactly(6).times.and_return('123dd', '1234')
    end

    it { expect { console_game.run }.to output { include I18n.t(:input_guess) }.to_stdout }
    it { expect { console_game.run }.not_to raise_error }
  end

  def game_init_and_set_values
    allow(console_game).to receive(:gets).and_return(name, difficulty)
    console_game.set_user
    console_game.set_game
  end
end
