class Post < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :favorited_members, through: :favorites, source: :member
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :events, dependent: :destroy

  has_one_attached :before_image
  has_one_attached :after_image

  validates :after_image, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :tool, presence: true
  validates :body, presence: true

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

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(name: new)
      self.tags << new_tag
    end
  end

  def self.search(keyword)
    where("title LIKE ? or body LIKE ?", "%#{sanitize_sql_like(keyword)}%", "%#{sanitize_sql_like(keyword)}%")
  end
end
