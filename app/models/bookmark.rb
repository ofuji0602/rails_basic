class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :board
  # 一つのユーザーは同じ投稿に対して一回しかブックマークができませんというバリデーション
  validates :user_id, uniqueness: { scope: :board_id }
end
