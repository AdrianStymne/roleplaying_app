class Message < ApplicationRecord
  belongs_to :player

  validates :content, presence: true, unless: :roll_data?

  scope :recent, -> { order(created_at: :desc) }

  def display_content
    if roll_data.present?
      "#{content} 🎲 Rolled: #{roll_data['result']} (#{roll_data['details']})"
    else
      content
    end
  end
end
