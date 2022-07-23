class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy
  has_many :cards, through: :taggables
  after_initialize :format_tag

  def self.normalize_name(name)
    name.downcase.gsub(/^#/, '')
  end
  private

  # Format the tag to be all lowercase and remove all leading '#' characters
  def format_tag
    self.name = Tag.normalize_name(self.name)
  end
end
