class UsersController < ApplicationController
  ## コントローラー実行前に処理。ストロングパラメーター参照
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    ## ユーザーIDで投稿を絞り込み
    @books = Book.where(user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

 private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    ## ユーザーID取得
    @user = User.find(params[:id])
    ## ログインユーザー以外ならBookindexへ
    redirect_to user_path(current_user) unless @user == current_user
  end
  
end
