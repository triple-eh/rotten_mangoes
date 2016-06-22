class MoviesController < ApplicationController
  def index
    query = params[:q]
    title = query[:title]
    director = query[:director]
    min_runtime = query[:runtime_in_minutes].split(',')[0]
    max_runtime = query[:runtime_in_minutes].split(',')[1]

    if params[:q] 
      @movies = Movie
      .title_contains(title)
      .director_contains(director)
      .min_runtime(min_runtime)
      .max_runtime(max_runtime)
    else 
      Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
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
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
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
