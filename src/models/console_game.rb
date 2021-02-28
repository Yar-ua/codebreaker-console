class ConsoleGame
  include IOHelper
  include Constants

  attr_reader :game, :response

  def initialize
    @game = Codebreaker::Game.new
    @response = {}
  end

  def create_user
    puts I18n.t(:user_registration)
    input = gets.chomp.strip
    game_user_init(input)
  end

  def create_difficulty
    puts I18n.t(:choose_level)
    game_difficulty_init(user_input)
  end

  def run
    puts I18n.t(:input_guess)
    input = user_input
    filter_user_input(input)
  rescue StandardError => e
    notice(e.message)
    run
  end

  private

  def filter_user_input(input)
    case input
    when EXIT then game_exit
    when HINT then take_hint
    else
      @response = @game.run(input)
    end
  end

  def game_user_init(input)
    @game.user_set(input)
  rescue StandardError => e
    notice(e.message)
    create_user
  end

  def game_difficulty_init(input)
    @game.difficulty_set(input)
  rescue StandardError => e
    notice(e.message)
    create_difficulty
  end

  def take_hint
    @response = @game.hint
  end
end
