class PatchPlaytestCards < Patch
  def call
    name_map = [
      "Bind",
      "Fire",
      "Liberate",
      "Start",
      "Smelt",
    ].map{|n| [n, "#{n} (CMB1)"]}
    .to_h
    name_map.default_proc = proc{|ht, x| x}

    each_printing do |card|
      next unless card["set_code"] == "cmb1"
      # Semantically they're split
      # Visually they're not
      # if card["layout"] == "split"
      #   card["layout"] = "playtest_split"
      # end

      card["name"] = name_map[card["name"]]
      if card["names"]
        card["names"] = card["names"].map{|n| name_map[n]}
      end

      # To match other cards
      if card["toughness"] == "*+1"
        card["toughness"] = "1+*"
      end
    end

    update_names_index
  end
end
