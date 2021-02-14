require 'spec_helper'

RSpec.describe ConsoleGame do
  let(:user) { User.new('username') }
  let(:game) { Codebreaker::Game.new('easy') }
  let(:console_game) { ConsoleGame.new }

  
  describe do


    it '' do
      # console_game.stub(:user, :game).and_return(user, game)
      # allow(console_game.initialize).to receive(:gets).and_return('easy')
      allow(ConsoleGame).to receive(:gets).with(user.name) #.and_call_original
      cg = ConsoleGame.new
      # expect(cg.user.name).to eq(user.name)
      # puts console_game.inspect
      # allow(console_game).to receive(:user).and_return(user)
    #   # allow(console_game).to receive(:game).and_return(nil)
    #   expect(console_game.user.name).to eq(user.name)
    end
  end

end
