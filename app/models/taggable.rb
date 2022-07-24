class Taggable < ApplicationRecord
  after_destroy :clean_up_tags
  belongs_to :card
  belongs_to :tag

  def clean_up_tags
    tag.destroy if tag.taggables.count.zero?
  end
end
