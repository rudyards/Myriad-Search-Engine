class ConditionIsPointed < Condition
  def search(db)
    names = [
      "Crucible of the Gods",
      "Danaal, the Last Tome Keeper",
      "Infernal Recall",
      "Mox Amethyst",
      "Mox Pyrope",
      "Timely Lesson",
      "Pactbound Mox",
      "Corpse Collector",
      "To Dream A Ship",
      "Dubious Tutor",
      "Vathi Siege Mage",
      "Collapsing Infrastructure",
      "Chromatic Cube",
      "Glimpse of Dawn",
      "Briar King's Wake",
      "Seeking the City",
      "Flee the City",
      "Wizard's Tactics",
      "Brimstone Gatekeeper",
      "Pilfered Mox",
      "Remake In My Image",
      "Where All Things Roam",
      "Boon Caller",
      "Corpse Collector",
      "Dilettante's Drive",
      "Vyreith, City-Souled",
      "Assemble the Heroes"
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:pointed"
  end
end
