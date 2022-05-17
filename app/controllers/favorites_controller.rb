class FavoritesController < ApplicationController
  def create
    logger.debug("favorite controller: create")
    @favorite = Favorite.new(book_id:params[:book_id])
    @favorite.user_id = current_user.id
    if @favorite.save
      redirect_to book_path(params[:book_id]), notice: "liked successfully."
    else
      redirect_to book_path(params[:book_id]), notice: "liked failed."
    end
  end
  def destroy
    logger.debug("favorite controller: destroy")
    bookId = params[:book_id]
    @favorite = Favorite.find_by(user_id:current_user.id, book_id:bookId)
    if @favorite.delete
      logger.debug("favorite controller: destroy success")
      redirect_to book_path(params[:book_id]), notice: "unliked successfully."
    else
      logger.debug("favorite controller: destroy failed")
      redirect_to book_path(params[:book_id]), notice: "unliked failed."
    end
  end
end
