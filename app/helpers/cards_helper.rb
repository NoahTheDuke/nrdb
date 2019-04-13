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
    CardType.import types
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
    types = CardType.all.index_by(&:code)
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
      new_card.card_type = types[convert_symbol(card[:type])] if card[:type]
      card[:subtype]&.each do |s|
        new_card.subtypes << subtypes[convert_symbol(s)]
      end
      new_card.save
    end
  end

  def import_cycles(path)
    path += 'cycles.edn'
    cycles = nil
    File.open(path) do |file|
      cycles = EDN.read(file)
    end
    cycles
      .select! { |cy| cy[:size] > 1 }
      .map! do |cy|
      {
        code: cy[:id],
        name: cy[:name],
        description: cy[:description],
      }
    end
    Cycle.import cycles
  end

  def import_set_types(path)
    path += 'set_types.edn'
    set_types = nil
    File.open(path) do |file|
      set_types = EDN.read(file)
    end
    set_types
      .map! do |set_type|
      {
        code: convert_symbol(set_type[:id]),
        name: set_type[:name],
      }
    end
    NrSetType.import set_types
  end

  def import_sets(path)
    nr_cycles = Cycle.all.index_by(&:code)
    nr_set_types = NrSetType.all.index_by(&:code)

    path += 'sets.edn'
    sets = nil
    File.open(path) do |file|
      sets = EDN.read(file)
    end
    sets.each do |set|
      new_set = NrSet.new(
        code: set[:id],
        name: set[:name],
        size: set[:size]
      )
      new_set.date_release = Date.parse(set[:"date-release"]) if set[:"date-release"]
      new_set.cycle = nr_cycles[set[:"cycle-id"]] if set[:"cycle-id"]
      if set[:"set-type"]
        new_set.nr_set_type = nr_set_types[convert_symbol(set[:"set-type"])]
      end
      new_set.save!
    end
  end

  def import_printings(path)
    set_cards = load_edn_from_dir(path + 'set-cards/*.edn').flatten
    raw_cards = Card.all.index_by(&:code)
    nr_sets = NrSet.all.index_by(&:code)

    set_cards.each do |set_card|
      card = raw_cards[set_card[:"card-id"]]
      nr_set = nr_sets[set_card[:"set-id"]]

      new_printing = Printing.new(
        printed_text: card[:text],
        printed_uniqueness: card[:uniqueness],
        code: set_card[:code],
        flavor: set_card[:flavor],
        illustrator: set_card[:illustrator],
        position: set_card[:position],
        quantity: set_card[:quantity],
        date_release: nr_set[:date_release]
      )
      new_printing.card = card
      new_printing.nr_set = nr_set

      new_printing.save
    end
  end

  def import
    path = '../netrunner-data/edn/'

    import_sides path
    import_factions path
    import_types path
    import_subtypes path
    import_cards path: path

    import_cycles path
    import_set_types path
    import_sets path
    import_printings path
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

  def type_builder(card)
    card_type = card.card_type.name
    if card.subtypes.present?
      card_type << ': '
      card_type << card.subtypes.map(&:name).join(' - ')
    end
    card_type
  end

  def versions(card)
    card.printings.order(:date_release).map do |c|
      c.nr_set.name
    end.join(' | ')
  end
end
