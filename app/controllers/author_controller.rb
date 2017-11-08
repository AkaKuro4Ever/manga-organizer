class AuthorController < ApplicationController

  #SEE AUTHOR PAGE ------------
  get '/authors/:id' do

    @author = Author.find_by(id: params[:id])

    erb :'authors/author'
  end

  #SEE ALL AUTHORS ------------

  get '/authors' do

    erb :'authors/authors'
  end
end
