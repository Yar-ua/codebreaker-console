require 'spec_helper'

RSpec.describe IOHelper do

  let(:console_interface) { ConsoleInterface.new }

  it { expect{console_interface.welcome}.to output(I18n.t(:welcome)).to_stdout }
  it { expect{console_interface.hello}.to output(I18n.t(:game_hello)).to_stdout }
  it { expect{console_interface.game_rules}.to output(I18n.t(:game_rules)).to_stdout }
  it { expect{console_interface.unknown_input}.to output(I18n.t(:unknown_input)).to_stdout }
  it { expect{console_interface.notice('some notice')}.to output("\e[0;31;49m" + I18n.t(:notice) + 'some notice' + "\e[0m\n").to_stdout }

  ###print_statistic
  ###user_input
  ### game_exit
  ### print_response(response)

end
