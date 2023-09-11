class Event < ApplicationRecord
  belongs_to :member
  belongs_to :post, optional: true
  
  validates :title, presence: true
end
