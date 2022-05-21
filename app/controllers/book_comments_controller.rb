class BookCommentsController < ApplicationController
  def create
    @bookComment = BookComment.new(book_id:params[:book_id], comment:params[:book_comment])
    @bookComment.user_id = current_user.id
    if @bookComment.save!
      redirect_to book_path(params[:book_id]), notice: "commented successfully."
    else
      redirect_to book_path(params[:book_id]), notice: "commented failed."
    end
  end
end
