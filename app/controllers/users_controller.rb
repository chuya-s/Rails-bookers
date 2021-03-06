class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    logger.debug("user_controller:show")
    # user, following/follower
    @user = User.find(params[:id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    # user books
    if @user.books
      @books = @user.books
    end
    @book = Book.new
    # post counts
    @todayPostCounts = Book.todayPostCounts(@user)
    @yesterdayPostCounts = Book.yesterdayPostCounts(@user)
    @twodaysPostCounts = Book.twodaysPostCounts(@user)
    @threedaysPostCounts = Book.threedaysPostCounts(@user)
    @fourdaysPostCounts = Book.fourdaysPostCounts(@user)
    @fivedaysPostCounts = Book.fivedaysPostCounts(@user)
    @sixdaysPostCounts = Book.sixdaysPostCounts(@user)
    @postCounts = [@sixdaysPostCounts, @fivedaysPostCounts, @fourdaysPostCounts, @threedaysPostCounts, @twodaysPostCounts, @yesterdayPostCounts, @todayPostCounts]
    logger.debug(@postCounts)
    @thisWeekPostCounts = Book.thisWeekPostCounts(@user)
    @prevWeekPostCounts = Book.prevWeekPostCounts(@user)
  end

  def index
    @users = User.all
    @book = Book.new
    @following_users = current_user.following_user
    @follower_users = current_user.follower_user
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

  def follows
    user = User.find(params[:id])
    @following_users = user.following_user
  end

  def followers
    user = User.find(params[:id])
    @follower_users = user.follower_user
  end

  def search
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      created_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{created_at}%"]).count
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
