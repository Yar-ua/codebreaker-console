class ConsoleGame
  include IOHelper

  attr_reader :user, :game, :response

  def initialize
    @user = user_registration
    @game = create_game
    @response = {}
  end
  
  def run
    puts I18n.t(:input_guess)
    input = user_input
    case input
    when 'exit' then game_exit
    when 'hint' then take_hint
    else
      @response = @game.run(input)
    end
  rescue => e
    notice(e.message)
    run
  end

  private

  def user_registration
    puts I18n.t(:user_registration)
    Codebreaker::User.new(user_input)
  rescue => e
    notice(e.message)
    user_registration
  end

  def create_game
    puts I18n.t(:choose_level)
    Codebreaker::Game.new(@user, user_input)
  rescue => e
    notice(e.message)
    create_game
  end

  def take_hint
    @response = @game.hint
  end

end
