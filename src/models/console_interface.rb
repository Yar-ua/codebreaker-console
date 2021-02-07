class ConsoleInterface
  include IOHelper

  def initialize
    @console_game = nil
  end

  def start
    welcome
    run
  end

  def run
    hello
    case user_input
    when "start" then game_start
    when "rules" then game_rules
    when "stats" then game_statistic
    when "exit" then game_exit
    else
      unknown_input
    end
    run
  end

  def game_start
    puts I18n.t(:game_start)
    @console_game = ConsoleGame.new
    game_process
  end

  def game_process
    puts @console_game.game.code    ###debug
    @console_game.run
    check_response
    puts @console_game.response ###if :ok or :hint or :no_hint
    game_process
  end

  def check_response
    win if @console_game.response[:status] == :win
    lose if @console_game.response[:status] == :lose
  end

  def win
    puts I18n.t(:win_message) + I18n.t(:secret_code) + @console_game.game.code
    new_game_or_menu
  end

  def lose
    puts I18n.t(:lose_message) + I18n.t(:secret_code) + @console_game.game.code
    new_game_or_menu
  end

  def new_game_or_menu
    puts I18n.t(:new_game)
    yes? ? game_start : run
  end

  def yes?
    user_input == "yes" || "y"
  end
end


