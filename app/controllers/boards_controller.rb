class BoardsController < ApplicationController
  # :edit, :update, :destroyアクションの前に必ず呼び出されるメソッドを設定
  before_action :find_board, only: [ :edit, :update, :destroy ]

  # 一覧表示アクション
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
  end

  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  # 新規作成フォームの表示アクション
  def new
    @board = Board.new
  end

  # ボードを作成するアクション
  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = t("defaults.message.created", item: Board.model_name.human)
      redirect_to boards_path
    else
      flash.now[:danger] = t("defaults.message.not_created", item: Board.model_name.human)
      render :new
    end
  end

  # ボードの詳細を表示するアクション
  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  # ボードを更新するアクション
  def update
    if @board.update(board_params)
      redirect_to @board, success: t("defaults.message.updated", item: Board.model_name.human)
    else
      flash.now[:danger] = t("defaults.message.not_updated", item: Board.model_name.human)
      render :edit
    end
  end

  # ボードを削除するアクション
  def destroy
    @board.destroy!
    redirect_to boards_path, success: t("defaults.message.deleted", item: Board.model_name.human)
  end

  # お気に入りボードの一覧表示アクション
  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  # 特定のボードを現在のユーザーのボードから見つけ、@boardにセットするメソッド
  def find_board
    @board = current_user.boards.find(params[:id])
  end

  # ボードのパラメータを許可するメソッド
  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
