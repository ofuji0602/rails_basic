class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :boards, dependent: :destroy
  # パスワードのバリデーション
  # 新しいレコードである場合、または `crypted_password` フィールドが変更された場合にのみ適用される
  # パスワードの長さが最低3文字であることを検証
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }

  # パスワードの確認
  # 新しいレコードである場合、または `crypted_password` フィールドが変更された場合にのみ適用される
  # パスワード確認が一致していることを検証
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }

  # パスワード確認の存在
  # 新しいレコードである場合、または `crypted_password` フィールドが変更された場合にのみ適用される
  # パスワード確認が存在することを検証
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # メールアドレスのバリデーション
  # メールアドレスが一意であることと、存在することを検証
  validates :email, uniqueness: true, presence: true

  # 名のバリデーション
  # 名が存在することと、長さが最大255文字であることを検証
  validates :first_name, presence: true, length: { maximum: 255 }

  # 姓のバリデーション
  # 姓が存在することと、長さが最大255文字であることを検証
  validates :last_name, presence: true, length: { maximum: 255 }
end
