class BooksController < ApplicationController
  ## コントローラー実行前に処理。ログインユーザーが対象
  before_action :correct_user, only: [:edit, :update]

  ## 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book[:id]), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    # 投稿ID取得
    @post = Book.find(params[:id])
    # 投稿データ内から投稿者IDを取得
    @user = User.find_by(id: @post.user_id)
    # モデル内の投稿者IDを絞り込み
    @books = Book.where(user_id: @post.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: "have destroyed book successfully."
  end

  ## 投稿データのストロングパラメー
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    ## 投稿ID取得
    @post = Book.find(params[:id])
    ## 投稿データ内から投稿者IDを取得
    @user = User.find_by(id: @post.user_id)
    ## ログインユーザー以外ならBookindexへ
    redirect_to(books_path) unless @user == current_user
  end
  
end
