require 'bundler/setup'
require 'codebreaker'
require 'yaml'
require 'i18n'
require 'colorize'
require 'tty-table'
require 'pry'

require_relative './modules/constants'
require_relative './helpers/io_helper'
require_relative './helpers/save_load_helper'

require_relative './models/stats'
require_relative './models/console_game'
require_relative './models/console_interface'

I18n.load_path << "#{File.expand_path('./config/locales')}/locale.yml"
I18n.default_locale = :en
