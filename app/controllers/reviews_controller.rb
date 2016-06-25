class ReviewsController < ApplicationController

  before_action :restrict_access, :load_movie

  def new
    @review = @movie.reviews.build
  end

  def create
    @review = @movie.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      response = {
        text: @review.text, 
        rating_out_of_ten: @review.rating_out_of_ten, 
        user: @review.user.full_name,
        user_profile_url: user_path(@review.user_id) 
      }.to_json
      render json: response
    else
      render :new
    end
  end

  protected

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:text,:rating_out_of_ten)
  end

end
