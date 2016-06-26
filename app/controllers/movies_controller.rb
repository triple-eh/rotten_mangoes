class MoviesController < ApplicationController
  def index
    if params[:q] 
      query = params[:q]
      search_term = query[:search_term]
      min_runtime = query[:runtime_in_minutes].split(',')[0]
      max_runtime = query[:runtime_in_minutes].split(',')[1]
      @movies = Movie
      .title_or_director_contains(search_term)
      .min_runtime(min_runtime)
      .max_runtime(max_runtime)
    else 
      @movies = Movie.all
    end

    @movie = Movie.new
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      avg_rating = @movie.review_average if @movie.reviews.any?
      response = {
        img_thumb_url: @movie.image.thumb.url,
        title: @movie.title,
        page_url: movie_path(@movie),
        release_date: @movie.release_date,
        director: @movie.director,
        desc: @movie.description,
        avg_rating: avg_rating
      }.to_json
      render json: response
       # notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected
    def movie_params
      params.require(:movie).permit(
        :title, :release_date, :director, :runtime_in_minutes, :image, :description, :remove_image
      )
    end
end
