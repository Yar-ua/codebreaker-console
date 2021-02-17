require 'spec_helper'

RSpec.describe IOHelper do
  let(:console_interface) { ConsoleInterface.new(load_config) }
  let(:game_response) { { status: :ok, message: '++--' } }
  let(:hint_response) { { status: :hint, message: '5' } }
  let(:user_text) { "SomE User teXT\n" }
  let(:user) { User.new('username') }
  let(:response) { { difficulty: 'easy', attempts_total: 15, attempts_used: 3, hints_total: 2, hints_used: 1 } }
  let(:statistic) { Stats.new(user, response) }
  let(:print_statistic) { console_interface.print_statistic([statistic]) }

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
      allow(console_interface).to receive(:gets).and_return(user_text)
      expect(console_interface.user_input).to eq(user_text.chomp.downcase)
    end
  end

  describe 'print codebreaker gem response' do
    it 'for :ok message' do
      expect { console_interface.print_response(game_response) }.to output(include game_response[:message]).to_stdout
    end

    it 'for :hint message' do
      expect { console_interface.print_response(hint_response) }.to output(include hint_response[:message]).to_stdout
    end
  end

  describe 'print statistic' do
    it 'message' do
      expect { print_statistic }.to output { include I18n.t(:game_statistic) }.to_stdout
    end

    it 'values' do
      expect { print_statistic }.to output {
                                      include statistic.name, response.difficulty, response.attempts_total, response.attempts_used, response.hints_total,
                                              response.hints_used
                                    }.to_stdout
    end
  end

  describe 'print game status' do
    it 'message and values' do
      c_game = double('ConsoleGame', user: user, attempts: '15', hints: '2')
      expect do
        console_interface.print_game_status(c_game)
      end.to output(include(I18n.t(:game_status), '15', '2')).to_stdout
    end
  end

  describe 'game exit' do
    it 'have exit message' do
      allow(console_interface).to receive(:exit)
      expect { console_interface.game_exit }.to output { include I18n.t(:game_exit) }.to_stdout
      expect(console_interface.game_exit).to eq(nil)
    end
  end
  
  after :all do
    File.delete('./db/test_top_users.yml') if File.exist?('./db/test_top_users.yml')
  end

  def load_config
    YAML.load_file(File.expand_path('../support/config_test.yml', __dir__))
  end
end
