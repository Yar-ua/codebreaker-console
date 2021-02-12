class Stats
  attr_reader :name, :difficulty, :attempts_total, :attempts_used, :hints_total, :hints_used

  def initialize(user, result)
    @name = user.name
    @difficulty = result[:difficulty]
    @attempts_total = result[:attempts_total]
    @attempts_used = result[:attempts_used]
    @hints_total = result[:hints_total]
    @hints_used = result[:hints_used]
  end
end
