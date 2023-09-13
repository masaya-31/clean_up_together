class Event < ApplicationRecord
  belongs_to :member
  belongs_to :post, optional: true

  validates :title, presence: true
  validates :start_time, presence: true
  validates :post_id, presence: true

  enum select_post: { no_post: 0, my_post: 1, favorite_post: 2 }

end
