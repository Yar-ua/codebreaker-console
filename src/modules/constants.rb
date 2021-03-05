module Constants
  DIFFICULTY_ORDER = %w[hell medium easy].freeze
  TABLE_HEADER = ['difficulty', 'name', 'attempts used', 'attempts', 'hints used', 'hints'].freeze
  START = 'start'.freeze
  RULES = 'rules'.freeze
  STATS = 'stats'.freeze
  EXIT = 'exit'.freeze
  YES = 'yes'.freeze

  OK = Codebreaker::Game::OK
  HINT = Codebreaker::Game::HINT
  WIN = Codebreaker::Game::WIN
  LOSE = Codebreaker::Game::LOSE
end
