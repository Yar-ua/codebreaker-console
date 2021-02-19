require 'spec_helper'

RSpec.describe Stats do
  subject(:stats) { described_class.new(user, result) }

  let(:user) { User.new('username') }
  let(:result) { { difficulty: 'easy', attempts_total: 15, attempts_used: 3, hints_total: 2, hints_used: 1 } }

  describe 'have all values after initialization' do
    it { expect(stats.difficulty).to eq(result[:difficulty]) }
    it { expect(stats.attempts_total).to eq(result[:attempts_total]) }
    it { expect(stats.attempts_used).to eq(result[:attempts_used]) }
    it { expect(stats.hints_total).to eq(result[:hints_total]) }
    it { expect(stats.hints_used).to eq(result[:hints_used]) }
    it { expect(stats).to be_an_instance_of(described_class) }
  end
end
