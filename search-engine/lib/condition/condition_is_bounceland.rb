class ConditionIsBounceland < Condition
  def search(db)
    names = [
      "Sprawling Coast",
      "Shaded Cove",
      "Scorched Sanctum",
      "Distant Highlands",
      "Suntouched Temple",
      "Boundless Sinks",
      "Crystal Coasts",
      "Lonely Morass",
      "Endless Deserts",
      "Unexplored Ruins",
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:bounceland"
  end
end
