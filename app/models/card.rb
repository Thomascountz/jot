class Card < ApplicationRecord
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  validates_presence_of :body
  before_create :generate_slug

  include PgSearch::Model
  pg_search_scope :search, against: [:body]

  def self.tagged_with(tag_name)
    Tag.find_by(name: tag_name).cards
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug = created_at.strftime('%Y%m%d%H%M')
  end

end
