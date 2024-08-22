class AddBoardImageToBoards < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:boards, :board_image)
      add_column :boards, :board_image, :string
    end
  end
end
