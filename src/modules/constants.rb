module Constants
  DIFFICULTY_ORDER = %w[hell medium easy].freeze
  TABLE_HEADER = ['difficulty', 'name', 'attempts used', 'attempts', 'hints used', 'hints'].freeze
  START = 'start'.freeze
  RULES = 'rules'.freeze
  STATS = 'stats'.freeze
  EXIT = 'exit'.freeze
  HINT = 'hint'.freeze
  YES = 'yes'.freeze

  OK = :ok
  HINT = :hint
  WIN = :win
  LOSE = :lose
end
