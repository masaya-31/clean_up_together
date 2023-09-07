class Post < ApplicationRecord
  belongs_to :member
  has_one_attached :image
  
  scope :published, -> {where(is_publish: true)}
  scope :unpublished, -> {where(is_publish: false)}
  
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
