class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:show, :update]

  def show
    @user = User.find(params[:id])
    if @user.books
      @books = @user.books
    end
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      action = params[:action]
      flash[:notice] = "No Authorized."
      if action == 'show'
        redirect_to users_path
      elsif action == 'update'
        redirect_to edit_user_path(current_user)
      end
    end
  end
end
