class Post < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :before_image
  has_one_attached :after_image
  validates :after_image, presence: true

  scope :published, -> {where(is_publish: true)}
  scope :unpublished, -> {where(is_publish: false)}

  def get_after_image(width, height)
    after_image.variant(resize_to_limit: [width, height]).processed
  end

  def get_before_image(width, height)
    before_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end
end
