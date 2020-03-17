class ConditionIsPointed < Condition
  def search(db)
    names = [
      "the crucible of the gods",
      "danaal, the last tome keeper",
      "infernal recall",
      "mox amethyst",
      "mox pyrope",
      "timely lesson",
      "pactbound mox",
      "corpse collector",
      "to dream a ship",
      "dubious tutor",
      "vathi siege mage",
      "collapsing infrastructure",
      "chromatic cube",
      "glimpse of dawn",
      "briar king's wake",
      "seeking the city",
      "flee the city",
      "wizard's tactics",
      "brimstone gatekeeper",
      "pilfered mox",
      "remake in my image",
      "where all things roam",
      "boon caller",
      "corpse collector",
      "dilettante's drive",
      "vyreith, city-souled",
      "assemble the heroes",
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
