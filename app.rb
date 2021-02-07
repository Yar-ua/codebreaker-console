require_relative './src/loader'

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
I18n.default_locale = :en

console_interface = ConsoleInterface.new
console_interface.start
