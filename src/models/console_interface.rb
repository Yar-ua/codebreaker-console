class ConsoleInterface
  include IOHelper
  include Game

  def run
    hello
    input = user_input
    case input
    when "start" then game_start
    when "rules" then game_rules
    when "stats" then game_statistic
    when "exit" then game_exit
    else
      unknown_input
    end
  end

  private 

  def hello
    puts I18n.t(:game_hello)
  end

  def game_rules
    puts I18n.t(:game_rules)
    run
  end

  def game_statistic
    puts I18n.t(:game_statistic)
    run
  end

  def unknown_input
    puts I18n.t(:unknown_input)
    run
  end

  def game_start
    puts I18n.t(:game_start)
    game_init
    game_run
  end


end


















# def user_input
#   gets.chomp.strip.downcase
# end

# def user_registration
#   puts 'Enter username'
#   @user = Codebreaker::User.new(user_input)
# rescue EmptyValueError, WrongTypeError, UserError => e
#   puts "NOTICE: #{e.message}"
#   user_registration
# end

# def game_init
#   @game = Codebreaker::Game.new(@user)
# end

# def show_response
#   puts @response
# end

# def run_game
#   puts "input your guess of code or input 'hint' to take a hint"
#   @response = @game.run(user_input)
#   case @response[:status]
#   when :win then win_game
#   when :lose then lose_game
#   else
#     show_response
#     run_game
#   end
# end



# hello
# user_registration
# puts @user.inspect

# game_init
# puts @game.inspect

# run_game
# puts @response
# puts @response[:status]