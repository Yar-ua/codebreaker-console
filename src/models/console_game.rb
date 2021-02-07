module Game
  include IOHelper

  def game_init
    @user = user_registration
    @game = create_game
    @response = {}
  end

  def user_registration
    puts "User registration. Input user name (3-20 symbols):"
    Codebreaker::User.new(user_input)
  rescue => e
    puts e.message
    user_registration
  end


  def create_game
    puts "choose game level: input 'easy', 'medium' or 'hard'"
    Codebreaker::Game.new(@user, user_input)
  rescue => e
    puts e.message
    create_game
  end


  def game_run
    puts 'input your value'
    input = user_input
    case input
    when 'exit' then game_exit
    when 'hint' then take_hint
    else
      @response = @game.run(input)
    end
    game_run
  rescue => e
    puts e.message
    game_run
  end

  def take_hint
    @response = @game.hint
  end












end