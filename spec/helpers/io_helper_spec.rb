require 'spec_helper'

RSpec.describe IOHelper do
  let(:console_interface) { ConsoleInterface.new(load_config) }
  let(:user) { User.new('username') }

  after do
    File.delete('./db/test_top_users.yml') if File.exist?('./db/test_top_users.yml')
  end

  it { expect { console_interface.welcome }.to output(I18n.t(:welcome)).to_stdout }
  it { expect { console_interface.hello }.to output(I18n.t(:game_hello)).to_stdout }
  it { expect { console_interface.game_rules }.to output(I18n.t(:game_rules)).to_stdout }
  it { expect { console_interface.unknown_input }.to output(I18n.t(:unknown_input)).to_stdout }

  it {
    expect do
      console_interface.notice('some notice')
    end.to output("\e[0;31;49m#{I18n.t(:notice)}some notice\e[0m\n").to_stdout
  }

  describe 'user_input method' do
    it 'return value what was inputed' do
      allow(console_interface).to receive(:gets).and_return("SomE User teXT\n")
      expect(console_interface.user_input).to eq("SomE User teXT\n".chomp.downcase)
    end
  end

  describe 'print codebreaker gem response' do
    it 'for :ok message' do
      expect do
        console_interface.print_response(Constants::GAME_RESPONSE)
      end.to output(include Constants::GAME_RESPONSE[:message]).to_stdout
    end

    it 'for :hint message' do
      expect do
        console_interface.print_response(Constants::HINT_RESPONSE)
      end.to output(include Constants::HINT_RESPONSE[:message]).to_stdout
    end
  end

  describe 'print statistic' do
    let(:print_statistic) { console_interface.print_statistic([Stats.new(user, response)]) }
    let(:response) { { difficulty: 'easy', attempts_total: 15, attempts_used: 3, hints_total: 2, hints_used: 1 } }

    it 'message' do
      expect { print_statistic }.to output { include I18n.t(:game_statistic) }.to_stdout
    end
  end

  describe 'print game status' do
    let(:c_game) { Codebreaker::Game.new('easy') }

    it 'message and values' do
      expect do
        console_interface.print_game_status(c_game)
      end.to output(include(I18n.t(:game_status), '15', '2')).to_stdout
    end
  end

  describe 'game exit' do
    it 'have exit message' do
      allow(console_interface).to receive(:exit)
      expect(console_interface.game_exit).to eq(nil)
    end
  end

  def load_config
    YAML.load_file(File.expand_path('../support/config_test.yml', __dir__))
  end
end
