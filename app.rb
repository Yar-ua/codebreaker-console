require_relative './src/loader'

console_interface = ConsoleInterface.new(YAML.load_file('./config/config.yml'))
console_interface.start
