class ConsoleInterface
  include IOHelper
  include SaveLoadHelper
  include Constants

  attr_reader :config, :console_game, :stats

  def initialize(config)
    @config = config
    @console_game = nil
    @stats = load_from_db(@config['db_file'])
  end

  def start
    welcome
    run_interface
  end

  private

  def run_interface
    hello
    case user_input
    when START then game_start
    when RULES then game_rules
    when STATS then game_statistic
    when EXIT then game_exit
    else
      unknown_input
    end
    run_interface
  end

  def game_start
    puts I18n.t(:game_start)
    @console_game = ConsoleGame.new
    @console_game.set_user
    @console_game.set_game
    game_process
  end

  def game_process
    @console_game.run
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
    yes? ? game_start : run_interface
  end

  def save_result(stats)
    puts I18n.t(:save_result)
    save_to_db(stats, @config['db_file']) if yes?
  end

  def yes?
    user_input == YES
  end

  def game_statistic
    sorted_stats = @stats
    sorted_stats.sort! { |a, b| [a.attempts_used, a.hints_used] <=> [b.attempts_used, b.hints_used] }
    sorted_stats.sort_by! { |d| DIFFICULTY_ORDER.index d.difficulty }
    print_statistic(sorted_stats)
  end
end
