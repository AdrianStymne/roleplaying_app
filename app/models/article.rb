class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Ensure tags is always an array
  before_save :normalize_tags

  scope :by_title, -> { order(:title) }
  scope :by_category, ->(category) { where(category: category) }
  scope :with_tag, ->(tag) { where("? = ANY(tags)", tag) }

  def excerpt(limit: 200)
    # Strip markdown and get plain text excerpt
    plain_text = content.gsub(/[*_`#\[\]()!-]/, "").strip
    plain_text.length > limit ? "#{plain_text[0..limit]}..." : plain_text
  end

  def rendered_content
    # For now, simple markdown-like rendering
    # You might want to use a gem like Redcarpet or Kramdown later
    content.gsub(/\*\*(.*?)\*\*/, '<strong>\1</strong>')
           .gsub(/\*(.*?)\*/, '<em>\1</em>')
           .gsub(/\n\n/, "<br><br>")
           .html_safe
  end

  private

  def normalize_tags
    self.tags = tags.map(&:strip).reject(&:blank?).uniq if tags.present?
  end
end
