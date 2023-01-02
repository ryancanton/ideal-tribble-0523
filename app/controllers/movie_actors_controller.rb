class MovieActorsController < ApplicationController
  def create
    MovieActor.create(movie_id: params[:movie_id], actor_id: params[:actor_id])
    redirect_to "/movies/#{params[:movie_id]}"
  end
end