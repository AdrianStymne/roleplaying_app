class Player < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_one :character_sheet, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
end
