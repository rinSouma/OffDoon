class Member < ApplicationRecord
  belongs_to :event
  belongs_to :user, :foreign_key => "uid"
  validates :uid, presence: true
  validates :kbn, presence: true
end
