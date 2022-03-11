class BooksController < ApplicationController
  def new
  @books = Book.new
  end

  ## 投稿データの保存
  def create
    @books = Book.new(post_image_params)
    @books.user_id = current_user.id
    @books.save
    redirect_to books_path
  end

  def index
    @books = Book.all
  end

  def show
  end

  ## 投稿データのストロングパラメー
  private

  def post_image_params
    params.require(:book).permit(:title, :body)
  end
end
