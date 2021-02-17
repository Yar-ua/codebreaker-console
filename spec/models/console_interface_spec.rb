require 'spec_helper'

RSpec.describe ConsoleInterface do
  subject(:console_interface) { described_class.new(load_config) }
  let(:console_game) { ConsoleGame.new() }
  let(:name) { 'John Sina' }
  let(:difficulty) { 'hard' }
  let(:win_response) { {status: :win, message: stats} }
  let(:lose_response) { {status: :lose} }
  let(:stats) { {difficulty: 'easy', attempts_total: 15, attempts_used: 3, hints_total: 2, hints_used: 1} }
  

  let(:user) { User.new(name) }

  describe 'have nil values when just created' do
    it { expect(subject.config).to eq(load_config) }
    it { expect(subject.console_game).to eq(nil) }
  end

  describe 'welcome message' do
    it '' do
      allow(subject).to receive(:run_interface).and_return(:exit)
      expect(subject).to receive(:welcome)
      subject.start
    end
  end

  describe 'run interface loop' do
    it '' do 
      ###=============>TODO: this is not working, going to unlimited loop
      allow(subject).to receive(:user_input).and_return('rules')
      allow(subject).to receive(:game_rules).and_return(:exit)
      expect(subject).to receive(:game_rules)
      subject.send(:run_interface)
      ###=============>TODO: this case is works but after 'exit' all other tests are finishing too
      # ci = subject.clone
      # allow(ci).to receive(:gets).and_return('stats', 'rules', 'start', 'unexpected', 'exit')
      # expect(ci).to receive(:game_start)
      # expect(ci).to receive(:game_rules)
      # expect(ci).to receive(:game_statistic)
      # expect(ci).to receive(:unknown_input)
      # ci.send(:run_interface)
    end
  end


  describe 'other methods' do
    before do
      console_game.instance_variable_set(:@user, User.new('username'))
      console_game.instance_variable_set(:@game, Codebreaker::Game.new('easy'))
      console_interface.instance_variable_set(:@console_game, console_game)
    end

    describe 'game process' do
      it '' do
        ###TODO this is not working too
        expect(subject).to receive_message_chain(:console_game, :run, :input).and_return('1234')
        expect(subject).to receive(:print_response)
        subject.send(:game_process)
      end
    end

    it 'win' do
      console_game.instance_variable_set(:@response, win_response)
      expect(subject).to receive(:user_input).and_return('yes')
      expect(subject).to receive(:new_game_or_menu)
      subject.send(:check_response)
    end

    it 'lose' do
      console_game.instance_variable_set(:@response, lose_response)
      expect(subject).to receive(:new_game_or_menu)
      subject.send(:check_response)
    end
  end

  describe 'new game or menu' do
    it 'new game' do
      expect(subject).to receive(:user_input).and_return('yes')
      expect(subject).to receive(:game_start)
      subject.send(:new_game_or_menu)
    end
    it 'menu' do
      expect(subject).to receive(:user_input).and_return('no')
      expect(subject).to receive(:run_interface)
      subject.send(:new_game_or_menu)
    end
  end

  describe 'game statistic' do
    it '' do
      expect(subject).to receive(:print_statistic)
      subject.send(:game_statistic)
    end
  end

  it 'yes?' do
    expect(subject).to receive(:user_input).and_return('yes')
    expect(subject.send(:yes?)).to eq(true)
  end

  after :all do
    File.delete('./db/test_top_users.yml') if File.exist?('./db/test_top_users.yml')
  end

  def load_config
    YAML.load_file(File.expand_path('../support/config_test.yml', __dir__))
  end

end
















  # describe 'game process' do
    # it '***' do
    #   allow(subject).to receive(:game_start).and_return(:exit)

    #   # allow(console_game).to receive(:gets).and_return(:exit)
    #   ci = double(console_interface)
    #   allow(ci).to receive(:console_game).and_return('aaa')
    #   expect(ci.console_game).to eq('aaa')
    #   # binding.pry

    #   # expect(subject).to receive(:game_process)
    #   subject.send(:game_start)
    #   binding.pry
    # end

  # end