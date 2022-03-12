class BooksController < ApplicationController
  def new
    @books = Book.new
  end

  ## 投稿データの保存
  def create
    @books = Book.new(post_image_params)
    @books.user_id = current_user.id
    if @books.save
      redirect_to book_path(params[:id]), notice: "Book was successfully created."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
  end

  def show
    @books = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
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
