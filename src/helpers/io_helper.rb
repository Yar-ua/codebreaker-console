module IOHelper
  def user_input
    gets.chomp.strip.downcase
  end
  
  def game_exit
    puts I18n.t(:game_exit)
    abort
  end
end