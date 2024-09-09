class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board

  # パスワードのバリデーション
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  # ボードをブックマークするメソッド
  def bookmark(board)
    bookmark_boards << board
  end

  # ブックマークを解除するメソッド
  def unbookmark(board)
    bookmark_boards.destroy(board)
  end

  # 指定したボードがブックマークされているかを確認するメソッド
  def bookmark?(board)
    bookmark_boards.include?(board)
  end

  # Ransack で検索可能な関連モデルを定義
  def self.ransackable_associations(auth_object = nil)
    [ "boards", "bookmark_boards", "bookmarks", "comments" ]
  end

  # Ransack で検索可能な属性を定義
  def self.ransackable_attributes(auth_object = nil)
    [ "first_name", "last_name", "email", "created_at", "updated_at", "role" ]
  end
end
