require 'spec_helper'

RSpec.describe User do
  let(:name) { 'username' }
  subject(:user) { described_class.new(name) }

  describe 'after initialize must have name' do
    it { expect(subject).to be_an_instance_of(User) }
    it { expect(subject.name).to eq(name) }
  end

  describe 'test validation' do
    it 'with empty or short name' do
      expect { described_class.new('ab') }.to raise_error(UserError, ConsoleInterface::USER_ERROR)
    end

    it 'with long name' do
      expect { described_class.new('a'*31) }.to raise_error(UserError, ConsoleInterface::USER_ERROR)
    end
  end
end
