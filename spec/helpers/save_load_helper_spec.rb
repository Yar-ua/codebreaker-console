require 'spec_helper'

RSpec.describe SaveLoadHelper do
  let(:console_interface) { ConsoleInterface.new(load_config) }
  let(:user) { Codebreaker::User.new('username') }
  let(:response) { { difficulty: 'easy', attempts_total: 15, attempts_used: 3, hints_total: 2, hints_used: 1 } }
  let(:stats) { Stats.new(user, response) }
  let(:config) { console_interface.config['db_file'] }

  describe 'load empty array if DB not exists' do
    it { expect(File.exist?('./db/not_exist.yml')).to be false }
    it { expect(console_interface.load_from_db('not_exist.yml')).to eq([]) }
  end

  describe 'save to DB' do
    before { console_interface.save_to_db(stats, config) }

    it { expect(File.exist?("./db/#{config}")).to be true }
    it { expect(File.open("./db/#{config}", 'r').read).to eq(stats.to_yaml) }
  end

  describe 'load from DB' do
    it 'and have equal values with test' do
      console_interface.save_to_db(stats, config)
      console_interface.load_from_db(config)
      expect(console_interface.stats.to_yaml).to eq(stats.to_yaml)
    end
  end

  def load_config
    YAML.load_file(File.expand_path('../support/config_test.yml', __dir__))
  end
end
