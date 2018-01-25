class User < ApplicationRecord
  has_many :members , :foreign_key => "uid"
  has_many :comments , :foreign_key => "uid"
  has_many :events , :foreign_key => "uid"
end
