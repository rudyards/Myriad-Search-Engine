# Digital sets often have BS realese date
describe "Sorting" do
  include_context "db"

  def ordered_search(query, *queries)
    results = Query.new(query).search(db).printings.uniq(&:card)
    queries = queries.map(&:to_proc)
    results.map{|c| queries.map{|q| q[c]}}
  end

  it "name" do
    ordered_search("t:chandra -is:digital -is:promo sort:name", :name).should eq([
      ["Chandra Ablaze"],
      ["Chandra Nalaar"],
      ["Chandra, Acolyte of Flame"],
      ["Chandra, Awakened Inferno"],
      ["Chandra, Bold Pyromancer"],
      ["Chandra, Fire Artisan"],
      ["Chandra, Flame's Fury"],
      ["Chandra, Flamecaller"],
      ["Chandra, Gremlin Wrangler"],
      ["Chandra, Novice Pyromancer"],
      ["Chandra, Pyrogenius"],
      ["Chandra, Pyromaster"],
      ["Chandra, Roaring Flame"],
      ["Chandra, Torch of Defiance"],
      ["Chandra, the Firebrand"],
    ])
  end

  it "artist" do
    ordered_search("t:chandra -is:digital -is:promo sort:artist", :name, :artist_name).should eq([
      ["Chandra Nalaar", "Aleksi Briclot"],
      ["Chandra, Acolyte of Flame", "Anna Steinbauer"],
      ["Chandra, Novice Pyromancer", "Anna Steinbauer"],
      ["Chandra, Awakened Inferno", "Chris Rahn"],
      ["Chandra, Pyromaster", "Chris Rahn"],
      ["Chandra, the Firebrand", "D. Alexander Gregory"],
      ["Chandra, Roaring Flame", "Eric Deschamps"],
      ["Chandra, Flamecaller", "Jason Rainville"],
      ["Chandra, Pyrogenius", "Jason Rainville"],
      ["Chandra, Gremlin Wrangler", "Kari Christensen"],
      ["Chandra, Flame's Fury", "Magali Villeneuve"],
      ["Chandra, Torch of Defiance", "Magali Villeneuve"],
      ["Chandra, Fire Artisan", "Ryota-H"],
      ["Chandra Ablaze", "Steve Argyle"],
      ["Chandra, Bold Pyromancer", "Zack Stella"],
    ])
  end

  it "new" do
    ordered_search("t:chandra -is:digital -is:promo sort:new", :name, :set_code).should eq([
      ["Chandra, Acolyte of Flame", "m20"],
      ["Chandra, Awakened Inferno", "m20"],
      ["Chandra, Flame's Fury", "m20"],
      ["Chandra, Novice Pyromancer", "m20"],
      ["Chandra, Fire Artisan", "war"],
      ["Chandra, Bold Pyromancer", "dom"],
      ["Chandra, Pyrogenius", "kld"],
      ["Chandra, Torch of Defiance", "kld"],
      ["Chandra, Flamecaller", "ogw"],
      ["Chandra, Roaring Flame", "ori"],
      ["Chandra, Pyromaster", "m15"],
      ["Chandra, the Firebrand", "m13"],
      ["Chandra Nalaar", "m11"],
      ["Chandra Ablaze", "zen"],
      ["Chandra, Gremlin Wrangler", "htr"],
    ])
  end

  it "newall" do
    ordered_search("t:chandra -is:digital -is:promo sort:newall", :name, :set_code).should eq([
      ["Chandra, Acolyte of Flame", "m20"],
      ["Chandra, Awakened Inferno", "m20"],
      ["Chandra, Flame's Fury", "m20"],
      ["Chandra, Novice Pyromancer", "m20"],
      ["Chandra, Fire Artisan", "war"],
      ["Chandra, Bold Pyromancer", "dom"],
      ["Chandra, Roaring Flame", "v17"],
      ["Chandra, Gremlin Wrangler", "htr"],
      ["Chandra, Pyromaster", "e01"],
      ["Chandra, Pyrogenius", "kld"],
      ["Chandra, Torch of Defiance", "kld"],
      ["Chandra, Flamecaller", "ogw"],
      ["Chandra Nalaar", "jvc"],
      ["Chandra, the Firebrand", "m13"],
      ["Chandra Ablaze", "zen"],
    ])
  end

  it "released" do
    ordered_search("t:chandra -is:digital -is:promo sort:newall", :name, :set_code).should eq(
      ordered_search("t:chandra -is:digital -is:promo sort:released", :name, :set_code))
  end

  it "old" do
    ordered_search("t:chandra -is:digital -is:promo sort:old", :name, :set_code).should eq([
      ["Chandra Nalaar", "lrw"],
      ["Chandra Ablaze", "zen"],
      ["Chandra, the Firebrand", "m12"],
      ["Chandra, Pyromaster", "m14"],
      ["Chandra, Roaring Flame", "ori"],
      ["Chandra, Flamecaller", "ogw"],
      ["Chandra, Pyrogenius", "kld"],
      ["Chandra, Torch of Defiance", "kld"],
      ["Chandra, Bold Pyromancer", "dom"],
      ["Chandra, Fire Artisan", "war"],
      ["Chandra, Acolyte of Flame", "m20"],
      ["Chandra, Awakened Inferno", "m20"],
      ["Chandra, Flame's Fury", "m20"],
      ["Chandra, Novice Pyromancer", "m20"],
      ["Chandra, Gremlin Wrangler", "htr"],
    ])
  end

  it "oldall" do
    ordered_search("t:chandra -is:digital -is:promo sort:oldall", :name, :set_code).should eq([
      ["Chandra Nalaar", "lrw"],
      ["Chandra Ablaze", "zen"],
      ["Chandra, the Firebrand", "m12"],
      ["Chandra, Pyromaster", "m14"],
      ["Chandra, Roaring Flame", "ori"],
      ["Chandra, Flamecaller", "ogw"],
      ["Chandra, Pyrogenius", "kld"],
      ["Chandra, Torch of Defiance", "kld"],
      ["Chandra, Gremlin Wrangler", "htr"],
      ["Chandra, Bold Pyromancer", "dom"],
      ["Chandra, Fire Artisan", "war"],
      ["Chandra, Acolyte of Flame", "m20"],
      ["Chandra, Awakened Inferno", "m20"],
      ["Chandra, Flame's Fury", "m20"],
      ["Chandra, Novice Pyromancer", "m20"],
    ])
  end

  it "cmc" do
    ordered_search("t:chandra -is:digital -is:promo sort:cmc", :name, :cmc).should eq([
      ["Chandra Ablaze", 6],
      ["Chandra, Awakened Inferno", 6],
      ["Chandra, Bold Pyromancer", 6],
      ["Chandra, Flame's Fury", 6],
      ["Chandra, Flamecaller", 6],
      ["Chandra, Pyrogenius", 6],
      ["Chandra Nalaar", 5],
      ["Chandra, Fire Artisan", 4],
      ["Chandra, Gremlin Wrangler", 4],
      ["Chandra, Novice Pyromancer", 4],
      ["Chandra, Pyromaster", 4],
      ["Chandra, Torch of Defiance", 4],
      ["Chandra, the Firebrand", 4],
      ["Chandra, Acolyte of Flame", 3],
      ["Chandra, Roaring Flame", 3],
    ])
  end

  it "-cmc" do
    ordered_search("t:chandra -is:digital -is:promo sort:-cmc", :name, :cmc).should eq([
      ["Chandra, Acolyte of Flame", 3],
      ["Chandra, Roaring Flame", 3],
      ["Chandra, Fire Artisan", 4],
      ["Chandra, Gremlin Wrangler", 4],
      ["Chandra, Novice Pyromancer", 4],
      ["Chandra, Pyromaster", 4],
      ["Chandra, Torch of Defiance", 4],
      ["Chandra, the Firebrand", 4],
      ["Chandra Nalaar", 5],
      ["Chandra Ablaze", 6],
      ["Chandra, Awakened Inferno", 6],
      ["Chandra, Bold Pyromancer", 6],
      ["Chandra, Flame's Fury", 6],
      ["Chandra, Flamecaller", 6],
      ["Chandra, Pyrogenius", 6],
    ])
  end

  it "set" do
    ordered_search("t:chandra -is:digital -is:promo sort:set", :name, :set_code, :number).should eq([
      ["Chandra Nalaar", "dd2", "34"],
      ["Chandra, Bold Pyromancer", "dom", "275"],
      ["Chandra, Pyromaster", "e01", "42"],
      ["Chandra, Gremlin Wrangler", "htr", "1"],
      ["Chandra, Torch of Defiance", "kld", "110"],
      ["Chandra, Pyrogenius", "kld", "265"],
      ["Chandra, the Firebrand", "m12", "124"],
      ["Chandra, Acolyte of Flame", "m20", "126"],
      ["Chandra, Awakened Inferno", "m20", "127"],
      ["Chandra, Novice Pyromancer", "m20", "128"],
      ["Chandra, Flame's Fury", "m20", "294"],
      ["Chandra, Flamecaller", "ogw", "104"],
      ["Chandra, Roaring Flame", "ori", "135b"],
      ["Chandra, Fire Artisan", "war", "119"],
      ["Chandra Ablaze", "zen", "120"],
    ])
  end

  it "-set" do
    ordered_search("t:chandra -is:digital -is:promo sort:-set", :name, :set_code, :number).should eq([
      ["Chandra Ablaze", "zen", "120"],
      ["Chandra, Fire Artisan", "war", "119"],
      ["Chandra, Roaring Flame", "v17", "6b"],
      ["Chandra, Flamecaller", "ogw", "104"],
      ["Chandra, Flame's Fury", "m20", "294"],
      ["Chandra, Novice Pyromancer", "m20", "128"],
      ["Chandra, Awakened Inferno", "m20", "127"],
      ["Chandra, Acolyte of Flame", "m20", "126"],
      ["Chandra, Pyromaster", "m15", "134"],
      ["Chandra, the Firebrand", "m13", "123"],
      ["Chandra Nalaar", "m11", "127"],
      ["Chandra, Pyrogenius", "kld", "265"],
      ["Chandra, Torch of Defiance", "kld", "110"],
      ["Chandra, Gremlin Wrangler", "htr", "1"],
      ["Chandra, Bold Pyromancer", "dom", "275"],
    ])
  end

  it "number" do
    ordered_search("t:planeswalker e:m10,m12 sort:number", :name, :set_code, :number).should eq([
      ["Ajani Goldmane", "m10", "1"],
      ["Jace Beleren", "m10", "58"],
      ["Liliana Vess", "m10", "102"],
      ["Chandra Nalaar", "m10", "132"],
      ["Garruk Wildspeaker", "m10", "183"],
      ["Gideon Jura", "m12", "16"],
      ["Jace, Memory Adept", "m12", "58"],
      ["Sorin Markov", "m12", "109"],
      ["Chandra, the Firebrand", "m12", "124"],
      ["Garruk, Primal Hunter", "m12", "174"],
    ])
  end

  it "-number" do
    ordered_search("t:planeswalker e:m10,m12 sort:-number", :name, :set_code, :number).should eq([
      ["Garruk, Primal Hunter", "m12", "174"],
      ["Chandra, the Firebrand", "m12", "124"],
      ["Sorin Markov", "m12", "109"],
      ["Jace, Memory Adept", "m12", "58"],
      ["Gideon Jura", "m12", "16"],
      ["Garruk Wildspeaker", "m10", "183"],
      ["Chandra Nalaar", "m10", "132"],
      ["Liliana Vess", "m10", "102"],
      ["Jace Beleren", "m10", "58"],
      ["Ajani Goldmane", "m10", "1"],
    ])
  end

  it "mixing orders" do
    ordered_search("t:chandra -is:digital -is:promo sort:cmc,-name", :name, :cmc).should eq([
      ["Chandra, Pyrogenius", 6],
      ["Chandra, Flamecaller", 6],
      ["Chandra, Flame's Fury", 6],
      ["Chandra, Bold Pyromancer", 6],
      ["Chandra, Awakened Inferno", 6],
      ["Chandra Ablaze", 6],
      ["Chandra Nalaar", 5],
      ["Chandra, the Firebrand", 4],
      ["Chandra, Torch of Defiance", 4],
      ["Chandra, Pyromaster", 4],
      ["Chandra, Novice Pyromancer", 4],
      ["Chandra, Gremlin Wrangler", 4],
      ["Chandra, Fire Artisan", 4],
      ["Chandra, Roaring Flame", 3],
      ["Chandra, Acolyte of Flame", 3],
    ])
  end

  it "sort:pow" do
    ordered_search("e:kld r:mythic t:artifact sort:pow", :name, :power, proc{|c| c.types.include?("vehicle")}).should eq([
      ["Combustible Gearhulk", 6, false],
      ["Skysovereign, Consul Flagship", 6, true],
      ["Noxious Gearhulk", 5, false],
      ["Torrential Gearhulk", 5, false],
      ["Cataclysmic Gearhulk", 4, false],
      ["Verdurous Gearhulk", 4, false],
      ["Aetherworks Marvel", nil, false],
    ])
  end

  it "sort:tou" do
    ordered_search("e:kld r:mythic t:artifact sort:tou", :name, :toughness, proc{|c| c.types.include?("vehicle")}).should eq([
      ["Combustible Gearhulk", 6, false],
      ["Torrential Gearhulk", 6, false],
      ["Cataclysmic Gearhulk", 5, false],
      ["Skysovereign, Consul Flagship", 5, true],
      ["Noxious Gearhulk", 4, false],
      ["Verdurous Gearhulk", 4, false],
      ["Aetherworks Marvel", nil, false],
    ])
  end

  it "random" do
    results1 = search("t:creature sort:rand")
    results2 = search("t:creature sort:name")
    results1.should_not eq(results2)
    results1.sort.should eq(results2.sort)
  end

  it "order: aliases sort:" do
    search("sort:cmc,-name").should eq search("order:cmc,-name")
  end

  let(:expected_color_order) {
    # Magic cards are ordered:
    # * colorless
    # * monocolored (wubrg)
    # * multicolored
    #
    # In most sets multicolored are grouped together.
    # Alara was ordered like below.
    # Wedges and 4/5-color order is completely arbitrary
    [
      "",
      "w", "u", "b", "r", "g",
      "wu", "ub", "br", "rg", "gw",
      "wb", "ur", "bg", "rw", "gu",
      "gwu", "wub", "ubr", "brg", "rgw",
      "bgw", "rwu", "gub", "wbr", "urg",
      "wubr", "ubrg", "brgw", "rgwu", "gwub",
      "wubrg",
    ].map{|cc| cc.chars.sort.join}
  }

  it "color" do
    order = db.search("sort:color").printings.map(&:colors).chunk(&:itself).map(&:first)
    order.should eq(expected_color_order)
  end

  it "ci" do
    order = db.search("sort:ci").printings.map(&:color_identity).chunk(&:itself).map(&:first)
    order.should eq(expected_color_order)
  end

  it "rarity" do
    order = db.search("sort:rarity").printings.map(&:rarity).chunk(&:itself).map(&:first)
    order.should eq(["special", "mythic", "rare", "uncommon", "common", "basic"])
  end
end
