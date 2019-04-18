class Card < ApplicationRecord
  belongs_to :side
  belongs_to :faction
  belongs_to :card_type
  has_and_belongs_to_many :subtypes
  has_many :printings

  validates :code, uniqueness: true
  validates :name, uniqueness: true

  def versions
    printings.includes(:nr_set).order(:date_release)
  end

  def strength_selector
    if strength.present?
      strength
    elsif agenda_points.present?
      agenda_points
    elsif trash_cost.present?
      trash_cost
    else
      ''
    end
  end

  def type_builder
    c_type = card_type.name
    if subtypes.present?
      c_type << ': '
      c_type << subtypes.map(&:name).join(' - ')
    end
    c_type
  end
end
