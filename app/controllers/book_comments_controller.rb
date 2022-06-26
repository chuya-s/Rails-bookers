class BookCommentsController < ApplicationController
  def create
    @bookComment = BookComment.new(book_id:params[:book_id], comment:params[:book_comment])
    @bookComment.user_id = current_user.id
    @bookComment.save
    redirect_to request.referer
  end

  def destroy
    bookCommentId = params[:book_comment_id]
    @bookComment = BookComment.find(bookCommentId)
    @bookComment.delete
    redirect_to request.referer
  end


end
