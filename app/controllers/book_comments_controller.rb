class BookCommentsController < ApplicationController
  def create
    @bookComment = BookComment.new(book_id:params[:book_id], comment:params[:book_comment])
    @bookComment.user_id = current_user.id
    if @bookComment.save
      redirect_to book_path(params[:book_id]), notice: "commented successfully."
    else
      redirect_to book_path(params[:book_id]), notice: "commented failed."
    end
  end

  def destroy
    bookCommentId = params[:book_comment_id]
    @bookComment = BookComment.find(bookCommentId)
    if @bookComment.delete
      redirect_to book_path(params[:book_id]), notice: "commented successfully."
    else
      redirect_to book_path(params[:book_id]), notice: "commented failed."
    end
  end


end
