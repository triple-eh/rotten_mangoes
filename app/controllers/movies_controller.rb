class MoviesController < ApplicationController
  def index
    query = params[:q]
    @movies = params[:q] ? Movie.where(
      '(title like :title) AND 
      (director like :director) AND 
      (runtime_in_minutes >= :start AND runtime_in_minutes <= :end)', 
      title: "%#{query[:title]}%", 
      director: "%#{query[:director]}%", 
      start: "#{query[:runtime_in_minutes].split(',')[0]}",
      end: "#{query[:runtime_in_minutes].split(',')[1]}"
      ) : Movie.all
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
