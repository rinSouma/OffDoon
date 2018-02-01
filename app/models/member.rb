class Member < ApplicationRecord
  belongs_to :event
  belongs_to :user, :foreign_key => "uid"
  validates :uid, presence: true
  validates :kbn, presence: true
  enum status: {join: 1, go_astray: 2, no_join: 3}
end
