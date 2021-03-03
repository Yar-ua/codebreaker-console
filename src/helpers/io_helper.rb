module IOHelper
  include Constants

  def welcome
    puts I18n.t(:welcome)
  end

  def hello
    puts I18n.t(:game_hello)
  end

  def game_rules
    puts I18n.t(:game_rules)
  end

  def print_statistic(sorted_stats)
    table = Terminal::Table.new
    table << TABLE_HEADER
    table.add_separator
    sorted_stats.each do |stat|
      table << [stat.difficulty, stat.name, stat.attempts_used, stat.attempts_total, stat.hints_used, stat.hints_total]
    end
    puts I18n.t(:game_statistic)
    puts table
  end

  def unknown_input
    puts I18n.t(:unknown_input)
  end

  def user_input
    gets.chomp.strip.downcase
  end

  def notice(message)
    puts (I18n.t(:notice) + message).colorize(:red)
  end

  def game_exit
    puts I18n.t(:exit_message)
    exit(0)
  end

  def print_response(response)
    puts response[:message].colorize(:green) if response[:status] == OK
    puts (I18n.t(:hint) + response[:message].to_s).colorize(:green) if response[:status] == HINT
  end

  def print_game_status(game)
    puts (I18n.t(:game_status) + game.attempts.to_s + I18n.t(:game_hints) + game.hints.to_s).colorize(:blue)
  end
end
