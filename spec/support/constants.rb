module Constants
  TEST_DB_PATH = './db/test_top_users.yml'.freeze
  WRONG_DB_PATH = './db/not_exist.yml'.freeze
  WRONG_FILENAME = 'not_exist.yml'.freeze
  YES = 'yes'.freeze
  NO = 'no'.freeze
  EASY = 'easy'.freeze
  HARD = 'hard'.freeze
  RULES = 'rules'.freeze
  STATS = 'stats'.freeze
  START = 'start'.freeze
  EXIT = 'exit'.freeze
  HINT = 'hint'.freeze
  USERNAME = 'username'.freeze
  UNKNOWN_INPUT = 'unknown input'.freeze
  GAME_RESPONSE = { status: :ok, message: '++--' }.freeze
  HINT_RESPONSE = { status: :hint, message: '5' }.freeze
end
