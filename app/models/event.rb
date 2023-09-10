class Event < ApplicationRecord
  belongs_to :member
  belongs_to :post, optional: true
end
