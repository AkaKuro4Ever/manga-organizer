class GenreController < ApplicationController

  #SEE GENRE PAGE ------------
  get '/genres/:id' do

    @genre = Genre.find_by(id: params[:id])

    erb :'/genres/genre'
  end

  get '/genres' do

    erb :'/genres/genres'
  end
end
