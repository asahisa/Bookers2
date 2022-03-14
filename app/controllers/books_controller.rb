class BooksController < ApplicationController
  ## 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to user_path(current_user[:id]), notice: "Book was successfully created."
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
    # 投稿IDから投稿者を取得
    @user = User.find_by(id: @post.user_id)
    # ユーザーIDからポストidを取得
    @books = Book.where(user_id: @post.user_id)
  end

  def edit
    @books = Book.find(params[:id])
  end

  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
      redirect_to book_path(@book.id), notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books", notice: "Book was successfully destroyed."
  end

  ## 投稿データのストロングパラメー
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
