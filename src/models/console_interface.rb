class ConsoleInterface
  include IOHelper
  include SaveLoadHelper

  attr_reader :console_game, :stats

  DIFFICULTY_ORDER = ["hard", "medium", "easy"]

  def initialize
    @console_game = nil
    @stats = load_from_db
  end

  def start
    welcome
    run_loop
  end

  def run_loop
    hello
    case user_input
    when "start" then game_start
    when "rules" then game_rules
    when "stats" then game_statistic
    when "exit" then game_exit
    else
      unknown_input
    end
    run_loop
  end

  def game_start
    puts I18n.t(:game_start)
    @console_game = ConsoleGame.new
    game_process
  end

  def game_process
    @console_game.run_loop
    check_response
    print_game_status(@console_game.game)
    print_response(@console_game.response)
    game_process
  end

  def check_response
    win if @console_game.response[:status] == :win
    lose if @console_game.response[:status] == :lose
  end

  def win
    puts I18n.t(:win_message) + I18n.t(:secret_code) + @console_game.game.code
    @stats << Stats.new(@console_game.user, @console_game.response[:message])
    save_result(@stats)
    new_game_or_menu
  end

  def lose
    puts I18n.t(:lose_message) + I18n.t(:secret_code) + @console_game.game.code
    new_game_or_menu
  end

  def new_game_or_menu
    puts I18n.t(:new_game)
    yes? ? game_start : run_loop
  end

  def save_result(stats)
    puts I18n.t(:save_result)
    save_to_db(stats) if yes?
  end

  def yes?
    user_input == "yes" ? true : false
  end

  def game_statistic
    sorted_stats = @stats
    sorted_stats.sort! { |a, b| [a.attempts_used, a.hints_used] <=> [b.attempts_used, b.hints_used] }
    sorted_stats.sort_by! { |d| DIFFICULTY_ORDER.index d.difficulty}
    print_statistic(sorted_stats)
  end

end
