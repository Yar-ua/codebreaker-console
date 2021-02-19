require 'spec_helper'

RSpec.describe ConsoleInterface do
  let(:console_interface) { described_class.new(load_config) }
  let(:console_game) { ConsoleGame.new }
  let(:lose_response) { { status: :lose } }
  let(:user) { User.new('John Sina') }
  let(:win_response) do
    { status: :win,
      message: { difficulty: Constants::EASY, attempts_total: 15, attempts_used: 3, hints_total: 2, hints_used: 1 } }
  end

  after do
    File.delete(Constants::TEST_DB_PATH) if File.exist?(Constants::TEST_DB_PATH)
  end

  describe 'have nil values when just created' do
    it { expect(console_interface.config).to eq(load_config) }
    it { expect(console_interface.console_game).to eq(nil) }
  end

  describe 'when run interface' do
    it 'have welcome' do
      allow(console_interface).to receive(:run_interface).and_return(:exit)
      allow(console_interface).to receive(:welcome)
      console_interface.start
      expect(console_interface).to have_received(:welcome)
    end
  end

  describe 'run interface loop' do
    before { allow(console_interface).to receive(:goto) }

    it 'rules' do
      allow(console_interface).to receive(:user_input).and_return(Constants::RULES)
      allow(console_interface).to receive(:game_rules)
      console_interface.send(:run_interface)
      expect(console_interface).to have_received(:game_rules)
    end

    it 'stats' do
      allow(console_interface).to receive(:user_input).and_return(Constants::STATS)
      allow(console_interface).to receive(:game_statistic)
      console_interface.send(:run_interface)
      expect(console_interface).to have_received(:game_statistic)
    end

    it 'start' do
      allow(console_interface).to receive(:user_input).and_return(Constants::START)
      allow(console_interface).to receive(:game_start)
      console_interface.send(:run_interface)
      expect(console_interface).to have_received(:game_start)
    end

    it 'unknown input' do
      allow(console_interface).to receive(:user_input).and_return(Constants::UNKNOWN_INPUT)
      allow(console_interface).to receive(:unknown_input)
      console_interface.send(:run_interface)
      expect(console_interface).to have_received(:unknown_input)
    end

    it 'exit' do
      allow(console_interface).to receive(:user_input).and_return(Constants::EXIT)
      allow(console_interface).to receive(:game_exit)
      console_interface.send(:run_interface)
      expect(console_interface).to have_received(:game_exit)
    end
  end

  describe 'IO interface methods' do
    before do
      console_game.instance_variable_set(:@user, User.new(Constants::USERNAME))
      console_game.instance_variable_set(:@game, Codebreaker::Game.new(Constants::EASY))
      console_interface.instance_variable_set(:@console_game, console_game)
    end

    it 'game process' do
      allow(console_interface.console_game).to receive(:run).and_return(:ok)
      allow(console_interface).to receive(:print_response)
      allow(console_interface).to receive(:goto)
      console_interface.send(:game_process)
    end

    it 'win' do
      console_game.instance_variable_set(:@response, win_response)
      allow(console_interface).to receive(:user_input).and_return(Constants::YES)
      allow(console_interface).to receive(:new_game_or_menu)
      console_interface.send(:check_response)
    end

    it 'lose' do
      console_game.instance_variable_set(:@response, lose_response)
      allow(console_interface).to receive(:new_game_or_menu)
      console_interface.send(:check_response)
    end
  end

  describe 'new game or menu' do
    it 'new game' do
      allow(console_interface).to receive(:user_input).and_return(Constants::YES)
      allow(console_interface).to receive(:game_start)
      console_interface.send(:new_game_or_menu)
    end

    it 'menu' do
      allow(console_interface).to receive(:user_input).and_return(Constants::NO)
      allow(console_interface).to receive(:run_interface)
      console_interface.send(:new_game_or_menu)
    end
  end

  describe 'game statistic' do
    it 'was sent' do
      allow(console_interface).to receive(:print_statistic)
      console_interface.send(:game_statistic)
    end
  end

  it 'yes?' do
    allow(console_interface).to receive(:user_input).and_return(Constants::YES)
    expect(console_interface.send(:yes?)).to eq(true)
  end

  it 'goto' do
    allow(console_interface).to receive(:start)
    console_interface.send(:goto, Constants::START)
  end

  def load_config
    YAML.load_file(File.expand_path('../support/config_test.yml', __dir__))
  end
end
