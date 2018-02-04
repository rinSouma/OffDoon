class Event < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :members, dependent: :destroy
  belongs_to :user, class_name: "User", foreign_key: "uid", optional: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  validates :limit, numericality: { only_integer: true, less_than_or_equal_to: 200 }
    
  validates :url, allow_blank: true, format: /\A#{URI::regexp(%w(http https))}\z/
  
  def self.search(user)
    #ユーザ情報がある（ログインしている場合）はドメインチェック
    #そうでなければ全体公開のもののみ取得
    if user
      where(["events.view = ? or events.view = ? or (events.view = ? and events.uid like ?)", 0, 1, 2, "%@"+user.domain])
    else
      where(['events.view = ?', 0])
    end
  end
  
end
