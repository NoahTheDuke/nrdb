class Card < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :side
  belongs_to :faction
  belongs_to :type
  has_and_belongs_to_many :subtypes

  validates :code, uniqueness: true
  validates :name, uniqueness: true
end
