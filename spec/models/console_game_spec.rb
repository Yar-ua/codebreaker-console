require 'spec_helper'

RSpec.describe ConsoleGame do
  subject(:console_game) { described_class.new }

  let(:name) { 'John Sina' }
  let(:difficulty) { 'hard' }

  describe 'have nil values when just created' do
    it { expect(subject.user).to eq(nil) }
    it { expect(subject.game).to eq(nil) }
  end

  describe 'set user value through' do
    before { allow(subject).to receive(:gets).and_return('1', name) }

    it 'rescue error with message' do
      expect { subject.set_user }.not_to raise_error
      expect { subject.set_user }.to output { include ConsoleInterface::USER_ERROR }.to_stdout
    end

    it 'user registration' do
      expect { subject.set_user }.to output { include I18n.t(:user_registration) }.to_stdout
      expect(subject.user.name).to eq(name)
    end
  end

  describe 'set game and difficulty' do
    before { allow(subject).to receive(:gets).and_return('smth', difficulty) }

    it 'rescue error with message' do
      expect { subject.set_game }.not_to raise_error
      expect { subject.set_game }.to output { include Codebreaker::ValidationHelper::INCORRECT_DIFFICULTY }.to_stdout
    end

    it 'game creation' do
      expect { subject.set_game }.to output { include I18n.t(:choose_level) }.to_stdout
      expect(subject.game.difficulty).to eq(difficulty)
    end
  end

  describe 'filter user input' do
    before { game_init_and_set_values }

    it 'take a hint' do
      expect(subject.send(:filter_user_input, 'hint')[:status]).to eq(:hint)
    end

    it 'exit' do
      allow(subject).to receive(:exit)
      expect(subject.send(:filter_user_input, 'exit')).to eq(nil)
      expect { subject.send(:filter_user_input, 'exit') }.to output { include I18n.t(:game_exit) }.to_stdout
    end

    it 'return response from Codebreaker gem' do
      expect(subject.send(:filter_user_input, '1234')[:status]).to eq(:ok)
    end
  end

  describe 'run' do
    before do
      game_init_and_set_values
    end

    it 'incorrect and correct user input' do
      allow(subject).to receive(:gets).exactly(6).times.and_return('123dd', '1234')
      expect { subject.run }.to output { include I18n.t(:input_guess) }.to_stdout
      expect { subject.run }.not_to raise_error
    end
  end

  def game_init_and_set_values
    allow(subject).to receive(:gets).and_return(name, difficulty)
    subject.set_user
    subject.set_game
  end
end
