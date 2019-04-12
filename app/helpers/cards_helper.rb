module CardsHelper
  def load_edn_from_dir(path)
    cards = []
    Dir.glob(path) do |f|
      next if File.directory? f

      File.open(f) do |file|
        cards << EDN.read(file)
      end
    end
    cards
  end

  def convert_symbol(type)
    return if type.nil?

    type.to_s.underscore
  end

  def convert_subtype(subtypes)
    return if subtypes.nil?

    subtypes.map(&:to_s).map(&:upcase_first).join(' - ')
  end

  def slugify(string)
    string
  end

  def import_sides(path)
    path += 'sides.edn'
    sides = nil
    File.open(path) do |file|
      sides = EDN.read(file)
    end
    sides
      .map! do |side|
      {
        code: convert_symbol(side[:id]),
        name: side[:name],
      }
    end
    Side.import sides
  end

  def import_factions(path)
    path += 'factions.edn'
    factions = nil
    File.open(path) do |file|
      factions = EDN.read(file)
    end
    factions
      .map! do |faction|
      {
        code: convert_symbol(faction[:id]),
        is_mini: faction[:"is-mini"],
        name: faction[:name],
      }
    end
    Faction.import factions
  end

  def import_types(path)
    path += 'types.edn'
    types = nil
    File.open(path) do |file|
      types = EDN.read(file)
    end
    types
      .map! do |type|
      {
        code: convert_symbol(type[:id]),
        name: type[:name],
      }
    end
    Type.import types
  end

  def import_subtypes(path)
    path += 'subtypes.edn'
    subtypes = nil
    File.open(path) do |file|
      subtypes = EDN.read(file)
    end
    subtypes
      .map! do |subtype|
      {
        code: convert_symbol(subtype[:id]),
        name: subtype[:name],
      }
    end
    Subtype.import subtypes
  end

  def import_cards(path: '../netrunner-data/edn/')
    cards = load_edn_from_dir(path + 'cards/*.edn')
    factions = Faction.all.index_by(&:code)
    sides = Side.all.index_by(&:code)
    types = Type.all.index_by(&:code)
    subtypes = Subtype.all.index_by(&:code)

    cards.each do |card|
      new_card = Card.new(
        advancement_requirement: card[:"advancement-requirement"],
        agenda_points: card[:"agenda-points"],
        base_link: card[:"base-link"],
        code: card[:id],
        cost: card[:cost],
        deck_limit: card[:"deck-limit"],
        influence_cost: card[:"influence-cost"],
        influence_limit: card[:"influence-limit"],
        memory_cost: card[:"memory-cost"],
        minimum_deck_size: card[:"minimum-deck-size"],
        name: card[:title],
        strength: card[:strength],
        text: card[:text],
        trash_cost: card[:"trash-cost"],
        uniqueness: card[:uniqueness]
      )
      new_card.faction = factions[convert_symbol(card[:faction])] if card[:faction]
      new_card.side = sides[convert_symbol(card[:side])] if card[:side]
      new_card.type = types[convert_symbol(card[:type])] if card[:type]
      card[:subtype]&.each do |s|
        new_card.subtypes << subtypes[convert_symbol(s)]
      end
      # new_card
      new_card.save
    end

    # p x.second.subtypes
    # x.second.save
    # Card.import x, recursive: true
    # cards.group_by(&:keys).each_value do |v|
    #   Card.import v, recursive: true
    # end
  end

  def import
    path = '../netrunner-data/edn/'
    import_sides path
    import_factions path
    import_types path
    import_subtypes path
    import_cards path: path
  end

  def strength_selector(card)
    if !card.strength.nil?
      card.strength
    elsif !card.agenda_points.nil?
      card.agenda_points
    elsif !card.trash_cost.nil?
      card.trash_cost
    else
      ''
    end
  end
end
