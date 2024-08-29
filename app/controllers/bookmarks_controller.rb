class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    flash[:success] = t("bookmarks.create.success")
    redirect_to request.referer || root_path
  end

  def destroy
    board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(board)
    flash[:success] = t("bookmarks.destroy.success")
    redirect_to request.referer || root_path
  end
end
