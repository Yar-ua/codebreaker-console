require 'spec_helper'

RSpec.describe Stats do
  let(:user) { User.new('username') }
  let(:result) { { difficulty: 'easy', attempts_total: 15, attempts_used: 3, hints_total: 2, hints_used: 1 } }
  subject(:stats) { described_class.new(user, result) }

  describe 'have all values after initialization' do
    it { expect(subject.name).to eq(user.name) }
    it { expect(subject.difficulty).to eq(result[:difficulty]) }
    it { expect(subject.attempts_total).to eq(result[:attempts_total]) }
    it { expect(subject.attempts_used).to eq(result[:attempts_used]) }
    it { expect(subject.hints_total).to eq(result[:hints_total]) }
    it { expect(subject.hints_used).to eq(result[:hints_used]) }
    it { expect(subject).to be_an_instance_of(Stats) }
  end
end
