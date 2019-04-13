class Card < ApplicationRecord
  belongs_to :side
  belongs_to :faction
  belongs_to :card_type
  has_and_belongs_to_many :subtypes
  has_many :printings

  validates :code, uniqueness: true
  validates :name, uniqueness: true
end
