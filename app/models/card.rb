class Card < ApplicationRecord
  validates_presence_of :body, :slug
  before_create :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug = created_at.strftime('%Y%m%d%H%M')
  end
end
