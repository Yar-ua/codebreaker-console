class Stats
  attr_reader :name

  def initialize(user, result)
    @name = user.name
    @result = result
  end

  def difficulty
    @result[:difficulty]
  end

  def attempts_total
    @result[:attempts_total]
  end

  def attempts_used
    @result[:attempts_used]
  end

  def hints_total
    @result[:hints_total]
  end

  def hints_used
    @result[:hints_used]
  end
end
