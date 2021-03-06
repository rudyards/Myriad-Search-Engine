class ConditionPart < Condition
  def initialize(cond)
    @cond = cond
  end

  def search(db)
    result = Set[]
    @cond.search(db).each do |c|
      if c.others
        result << c
        result.merge(c.others)
      end
    end
    result
  end

  def metadata!(key, value)
    super
    @cond.metadata!(key, value)
  end

  def to_s
    "part:#{@cond}"
  end
end
