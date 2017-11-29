require 'pry'
class BookController < ApplicationController

  get '/manga/new' do
    erb :'/book/new'
  end

  #SEE ENTIRE MANGA COLLECTION PAGE -------
  get '/manga' do

    erb :'/book/manga'
  end

  #CREATING NEW MANGA ------------
  post '/manga' do
    author = params[:manga][:author].strip.split.map(&:capitalize).join(' ')
    genre = params[:manga][:genre].strip.split.map(&:capitalize).join(' ')

    if !params[:manga][:title].empty?
      @book = Book.new(title: params[:manga][:title].split.map(&:capitalize).join(' '), volume: params[:manga][:volume])
    end
    #If both are authors filled, redirects
    #If title is not filled out, redirects
    if !author.empty? && params[:manga][:author_id] || params[:manga][:title] == ""
      redirect '/manga/error/1'
    #If top is filled out, but author exists, it assigns existing author
  elsif !author.empty? && Author.check(author)
      @book.author = Author.find_by(name: author)
    #If top is filled out and author doesn't exist, it assigns top
  elsif !author.empty?
      @book.author = Author.create(name: author)
    #If top isn't filled out, it assigns bottom
    else
      @book.author = Author.find_by(id: params[:manga][:author_id])
    end
    #If top is filled out, but genre exists, it assigns existing genre
    if !genre.empty? && Genre.check(genre)
      @book.genres << Genre.find_by(name: genre)
    #If top is filled out and genre doesn't exist, it assigns top
  elsif !genre.empty?
      @book.genres << Genre.create(name: genre)
    #If top isn't filled out, it assigns bottom
    end
    if params[:manga][:genre_ids]
      params[:manga][:genre_ids].each do |id|
        @book.genres << Genre.find_by(id: id)
      end
    end

    if @book.save
      if logged_in?
        current_user.books << @book
      end
      current_user
      erb :'/book/book'
    else
      @message = "It seems that you've had an error while creating a new manga! Make sure you only listed one author and have filled in a title."
      erb :'book/new'
    end
  end

  #SEE INDIV MANGA BOOK PAGE ----------
  get '/manga/:id' do
    @book = Book.find_by(id: params[:id])
    if @book
      erb :'/book/book'
    else
      @message = "This book does not exist. Please try to search for a different book."
      redirect to '/manga'
    end
  end

  #ADD INDIV MANGA TO USER'S PROFILE PAGE---
  post '/manga/:id/add' do
    @book = Book.find_by(id: params[:id])
    current_user.books << @book
    if !current_user.books << @book
      @message = "It seems there was an error editing this book from your collection. Please try again."
    end
    redirect to "users/#{current_user.id}"
  end

  #REMOVE INDIV MANGA TO USER'S PROFILE PAGE---
  delete '/manga/:id/remove' do
    @book = Book.find_by(id: params[:id])
    if !current_user.books.delete(@book)
      @message = "It seems there was an error editing this book from your collection. Please try again."
    end
    redirect "users/#{current_user.id}"
  end
  #ERROR WHEN FILLING OUT DELETE MANGA --
  get '/manga/error/1' do
    erb :error
  end

  #EDIT INDIV MANGA BOOK DETAILS
  get '/manga/:id/edit' do
    @book = Book.find_by(id: params[:id])

    if @book
      erb :'/book/edit'
    else
      @message = "This book does not exist. Please try to search for a different book."
      redirect to '/manga'
    end
  end

  patch '/manga/:id' do
    @book = Book.find_by(id: params[:id])

    author = params[:manga][:author].strip.split.map(&:capitalize).join(' ')
    genre = params[:manga][:genre].strip.split.map(&:capitalize).join(' ')

    @book.title = params[:manga][:title].split.map(&:capitalize).join(' ') if !params[:manga][:title].empty?
    @book.volume = params[:manga][:volume] if !params[:manga][:volume].empty?

    if !author.empty? && params[:manga][:author_id]
      @message = "Please make sure you only list one author in either the text box or the list."
      @book.author = Author.find_by(name: author) if !author.empty? && Author.check(author)
      @book.author = Author.create(name: author) if !author.empty? && !Author.check(author)

      @book.author = Author.find_by(id: params[:manga][:author_id]) if params[:manga][:author_id] && author.empty?
      redirect to "/manga/#{@book.id}/edit"
    end

    @book.genres.delete_all
    @book.genres << Genre.find_by(name: genre) if !genre.empty? && Genre.check(genre)
    @book.genres << Genre.create(name: genre) if !genre.empty?

    if params[:manga][:genre_ids]
      params[:manga][:genre_ids].each { |id| @book.genres << Genre.find_by(id: id) }
    else
      @book.genres = []
    end

    if @book.save

      redirect to "/manga/#{@book.id}"
    else
      @message = "It seems that you've had an error while editing this manga! Make sure you only listed one author and have filled in a title."
      erb :'/book/edit'
    end
  end

  delete '/manga/:id' do
    @book = Book.find_by(id: params[:id])
    if @book.delete
      redirect '/manga'
    else
      erb :error
    end
  end
end
