class User
  attr_accessor :name

  def initialize(name)
    validate(name)
    @name = name
  end

  private

  def validate(name)
    raise UserError.new "Name length must be between 3 and 20" if (name.length < 3 ) || (name.length > 20)
  end
end
