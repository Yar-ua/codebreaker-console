class User
  include Constants
  attr_accessor :name

  def initialize(name)
    validate(name)
    @name = name
  end

  private

  def validate(name)
    raise UserError, USER_ERROR if (name.length < 3) || (name.length > 20)
  end
end
