class BoardsController < ApplicationController
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

  private

  # ボードのパラメータを許可するメソッド
  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
