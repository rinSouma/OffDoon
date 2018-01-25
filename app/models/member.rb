class Member < ApplicationRecord
  belongs_to :event
  validates :uid, presence: true
  validates :kbn, presence: true
end
