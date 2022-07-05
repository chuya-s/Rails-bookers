class BooksController < ApplicationController
  before_action :ensure_correct_book, only: [:edit, :show]

  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @bookComment = BookComment.new
    @bookComments = BookComment.where(user_id: current_user.id, book_id: params[:id])
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_book
    @book = Book.find(params[:id])
    unless @book.user == current_user
      action = params[:action]
      if action == 'edit'
        flash[:notice] = "No Authorized."
        redirect_to book_path(params[:id])
      end
    end
  end
end
