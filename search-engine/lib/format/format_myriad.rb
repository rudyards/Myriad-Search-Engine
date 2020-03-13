# This is loaded manually in format.rb, go there to tell it to load more formats or change the order.

class FormatMyriad < Format

  def format_pretty_name
    "Myriad"
  end

  def build_included_sets
    Set[
      "RWR", "101", "TMA", "HIL", "ILD", "DOA"
      
    ]
  end
end
