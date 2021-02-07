module IOHelper

  def welcome
    puts I18n.t(:welcome)
  end

  def hello
    puts I18n.t(:game_hello)
  end

  def game_rules
    puts I18n.t(:game_rules)
  end

  def game_statistic
    puts I18n.t(:game_statistic)
  end

  def unknown_input
    puts I18n.t(:unknown_input)
  end

  def user_input
    gets.chomp.strip.downcase
  end

  def notice(message)
    puts I18n.t(:notice) + message
  end
  
  def game_exit
    puts I18n.t(:game_exit)
    abort
  end

  def print_response(response)
    puts response[:message] if response[:status] == :ok
    puts I18n.t(:hint) + response[:message] if response[:status] == :hint
  end

  def print_game_status(game)
    puts I18n.t(:game_status) + game.attempts.to_s + I18n.t(:hints) + game.hints.to_s
  end

end
