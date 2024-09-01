class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 280 }
  # Ransack で検索可能な属性を定義
  def self.ransackable_attributes(auth_object = nil)
    [ "title", "body", "created_at", "updated_at" ]
  end

  # Ransack で検索可能な関連モデルを定義
  def self.ransackable_associations(auth_object = nil)
    [ "comments", "user" ]
  end
end
