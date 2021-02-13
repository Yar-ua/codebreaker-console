require 'spec_helper'

RSpec.describe UserError do
  let(:user) { User.new(name) }
  let(:name) { 'aa' }

  describe 'raise UserError if something wrong' do
    it { expect { user }.to raise_error(described_class) }
  end
end
