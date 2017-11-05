class BookController < ApplicationController

  get '/manga/new' do

    erb :new
  end

  post '/manga' do
    #make sure that if volume is already existing, it links to that book's homepage
    #make a book homepage that you can edit
    #later must make a user page you can edit with the books in your collection
    #must be able to add and delete books on that same edit page (Look back at that figure/landmark assignment)
    title = params[:manga][:title].capitalize

    author = params[:manga][:author].split.map(&:capitalize).join(' ')

    genre = params[:manga][:genre].split.map(&:capitalize).join(' ')

    @book = Book.new(title: title, volume: params[:manga][:volume], author: author, genre: genre)
    @book.save

    erb :book
  end
end
