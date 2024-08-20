class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    # boardsテーブルを作成します
    create_table :boards do |t|
      # titleカラムを作成します。文字列型で、nullを許可しません。
      t.string :title, null: false

      # bodyカラムを作成します。text型で、nullを許可しません。
      # text型を選択した理由は、長文が保存できるからです。
      t.text :body, null: false

      # user_idカラムを作成します。references型を使用することで、他のテーブル(userテーブル)との関連付けを行います。
      # foreign_key: trueにより、user_idがuserテーブルのidに対する外部キー制約を持つようになります。
      t.references :user, foreign_key: true

      # timestampsはcreated_atとupdated_atという2つのカラムを自動的に作成します。
      # レコードが作成された日時と更新された日時を自動的に管理するために使用されます。
      t.timestamps
    end
  end
end
