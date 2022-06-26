class BookCommentsController < ApplicationController
  def create
    @bookComment = BookComment.new(comment_params)
    @bookComment.book_id = params[:book_id]
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

  private

  def comment_params
    params.require(:book_comment).permit(:comment)
  end

end
