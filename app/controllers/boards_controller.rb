class BoardsController < ApplicationController
  # :edit, :update, :destroyアクションの前に必ず呼び出されるメソッドを設定
  before_action :find_board, only: [ :edit, :update, :destroy ]
  # 一覧表示アクション
  def index
    # 全てのボードを取得し、ユーザー情報も一緒に読み込む
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  # 新規作成フォームの表示アクション
  def new
    @board = Board.new
  end

  # ボードを作成するアクション
  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      # 成功した場合、成功メッセージを表示し、ボード一覧ページへリダイレクト
      flash[:success] = t("defaults.message.created", item: Board.model_name.human)
      redirect_to boards_path
    else
      # 失敗した場合、エラーメッセージを表示し、新規作成フォームを再表示
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
    # find_boardメソッドでセットされた@boardを更新
    if @board.update(board_params)
      # 更新に成功した場合、@boardの詳細ページにリダイレクトし、成功メッセージを表示
      redirect_to @board, success: t("defaults.message.updated", item: Board.model_name.human)
    else
      # 更新に失敗した場合、エラーメッセージをフラッシュで表示し、editページを再レンダリング
      flash.now["danger"] = t("defaults.message.not_updated", item: Board.model_name.human)
      render :edit
    end
  end

  # ボードを削除するアクション
  def destroy
    # find_boardメソッドでセットされた@boardを削除
    @board.destroy!
    # 削除後、ボード一覧ページにリダイレクトし、削除成功メッセージを表示
    redirect_to boards_path, success: t("defaults.message.deleted", item: Board.model_name.human)
  end

  def bookmarks
    @bookmark_boards = current_user.bookmark_boards.includes(:user).order(created_at: :desc)
  end

  private

  # 特定のボードを現在のユーザーのボードから見つけ、@boardにセットするメソッド
  def find_board
    @board = current_user.boards.find(params[:id])
  end

  # ボードのパラメータを許可するメソッド
  private
  def board_params
    # params.require(:board)でboardパラメータを取得し、その中で許可するパラメータを指定
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
