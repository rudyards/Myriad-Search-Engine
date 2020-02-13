describe "Sets" do
  include_context "db"

  let(:known_set_types) do
    [
      "archenemy",
      "arena league",
      "booster",
      "box",
      "commander",
      "conspiracy",
      "core",
      "deck",
      "draft innovation",
      "duel deck",
      "duels",
      "expansion",
      "fixed",
      "fnm",
      "from the vault",
      "funny",
      "gateway",
      "judge gift",
      "masterpiece",
      "masters",
      "memorabilia",
      "modern",
      "multiplayer",
      "planechase",
      "player rewards",
      "portal",
      "premiere shop",
      "premium deck",
      "promo",
      "spellbook",
      "standard",
      "starter",
      "token",
      "treasure chest",
      "two-headed giant",
      "un",
      "vanguard",
      "wpn",
    ].to_set
  end

  it "all sets have sensible type" do
    db.sets.values.flat_map(&:types).sort.to_set.should eq known_set_types
  end
end
