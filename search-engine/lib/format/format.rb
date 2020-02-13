class Format
  attr_reader :included_sets, :excluded_sets

  def initialize(time=nil)
    raise ArgumentError unless time.nil? or time.is_a?(Date)
    @time = time
    @ban_list = BanList[format_name]
    if respond_to?(:build_included_sets)
      @included_sets = build_included_sets
      @excluded_sets = nil
    else
      @included_sets = nil
      @excluded_sets = build_excluded_sets
    end
  end

  def legality(card)
    card = card.main_front if card.is_a?(PhysicalCard)
    if card.extra or !in_format?(card)
      nil
    else
      @ban_list.legality(card.name, @time)
    end
  end

  def banned?(card)
    legality(card) == "banned"
  end

  def restricted?(card)
    legality(card) == "restricted"
  end

  def legal?(card)
    legality(card) == "legal"
  end

  def legal_or_restricted?(card)
    l = legality(card)
    l == "legal" or l == "restricted"
  end

  def in_format?(card)
    card.printings.each do |printing|
      next if @time and printing.release_date > @time
      if @included_sets
        next unless @included_sets.include?(printing.set_code)
      else
        next if @excluded_sets.include?(printing.set_code)
      end
      return true
    end
    false
  end

  def deck_issues(deck)
    [
      *deck_size_issues(deck),
      *deck_card_issues(deck),
    ]
  end

  def deck_size_issues(deck)
    issues = []
    if deck.number_of_mainboard_cards < 60
      issues << "Deck must contain at least 60 mainboard cards, has only #{deck.number_of_mainboard_cards}"
    end
    if deck.number_of_sideboard_cards > 15
      issues << "Deck must contain at most 15 sideboard cards, has #{deck.number_of_sideboard_cards}"
    end
    issues
  end

  def deck_card_issues(deck)
    issues = []
    deck.card_counts.each do |card, name, count|
      card_legality = legality(card)
      case card_legality
      when "legal"
        if count > 1 and not card.allowed_in_any_number?
          issues << "Deck contains #{count} copies of #{name}, only up to 1 allowed"
        end
      else
        issues << "#{name} is not in the format"
      end
    end
    issues
  end

  def format_pretty_name
    raise "Subclass responsibility"
  end

  def format_name
    format_pretty_name.downcase
  end

  def to_s
    if @time
      "<Format:#{format_name}:#{@time}>"
    else
      "<Format:#{format_name}>"
    end
  end

  def inspect
    to_s
  end

  def ban_events
    @ban_list.events
  end

  class << self
    def formats_index
      # Removed spaces so you can say "lw block" lw-block lwblock lw_block or whatever
      {
        "modern"                     => FormatModern,
      }
    end

    def all_format_classes
      @all_format_classes ||= formats_index.values.uniq
    end

    def [](format_name)
      format_name = format_name.downcase.gsub(/\s|-|_/, "")
      return FormatAny if format_name == "*"
      formats_index[format_name] || FormatUnknown
    end
  end
end


Dir["#{__dir__}/format_*.rb"].each do |path| require_relative path end
