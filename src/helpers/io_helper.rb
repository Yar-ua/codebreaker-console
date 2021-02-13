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
    puts I18n.t(:game_statistic)
    table = TTY::Table.new
    table << TABLE_HEADER
    sorted_stats.each do |s|
      table << [s.difficulty, s.name, s.attempts_used, s.attempts_total, s.hints_used, s.hints_total]
    end
    puts TTY::Table::Renderer::Unicode.new(table).render
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
    puts I18n.t(:game_exit)
    abort
  end

  def print_response(response)
    puts response[:message].colorize(:green) if response[:status] == :ok
    puts (I18n.t(:hint) + response[:message].to_s).colorize(:green) if response[:status] == :hint
  end

  def print_game_status(game)
    puts (I18n.t(:game_status) + game.attempts.to_s + I18n.t(:game_hints) + game.hints.to_s).colorize(:blue)
  end
end
