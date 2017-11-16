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

    if params[:manga][:title] != ""
      @book = Book.new(title: params[:manga][:title].split.map(&:capitalize).join(' '), volume: params[:manga][:volume])
    end
    #If both are authors filled, redirects
    #If title is not filled out, redirects
    if author != "" && params[:manga][:author_id] != nil || params[:manga][:title] == ""
      redirect '/manga/error/1'
    #If top is filled out, but author exists, it assigns existing author
    elsif author != "" && Author.check(author)
      @book.author = Author.find_by(name: author)
    #If top is filled out and author doesn't exist, it assigns top
    elsif author != ""
      @book.author = Author.create(name: author)
    #If top isn't filled out, it assigns bottom
    else
      @book.author = Author.find_by(id: params[:manga][:author_id])
    end
    #If top is filled out, but genre exists, it assigns existing genre
    if genre != "" && Genre.check(genre)
      @book.genres << Genre.find_by(name: genre)
    #If top is filled out and genre doesn't exist, it assigns top
    elsif genre != ""
      @book.genres << Genre.create(name: genre)
    #If top isn't filled out, it assigns bottom
    end
    if params[:manga][:genre_ids] != nil
      params[:manga][:genre_ids].each do |id|
        @book.genres << Genre.find_by(id: id)
      end
    end

  @book.save
    if logged_in?
      current_user.books << @book
    end
    current_user
    erb :'/book/book'
  end

  #ERROR WHEN FILLING OUT NEW MANGA FORM
  get '/manga/error/1' do

    erb :error
  end
  #SEE INDIV MANGA BOOK PAGE ----------
  get '/manga/:id' do
    @book = Book.find_by(id: params[:id])
    if @book
      erb :'/book/book'
    else
      redirect to '/manga'
    end
  end

  #ADD INDIV MANGA TO USER'S PROFILE PAGE---
  post '/manga/:id/add' do
    @book = Book.find_by(id: params[:id])
    current_user.books << @book
    redirect to "users/#{current_user.id}"
  end

  #REMOVE INDIV MANGA TO USER'S PROFILE PAGE---
  delete '/manga/:id/remove' do
    @book = Book.find_by(id: params[:id])
    current_user.books.delete(@book)
    redirect to "users/#{current_user.id}"
  end

  #EDIT INDIV MANGA BOOK DETAILS
  get '/manga/:id/edit' do
    @book = Book.find_by(id: params[:id])
    erb :'book/edit'
  end

  put '/manga/:id' do
    @book = Book.find_by(id: params[:id])

    author = params[:manga][:author].strip.split.map(&:capitalize).join(' ')
    genre = params[:manga][:genre].strip.split.map(&:capitalize).join(' ')
    #Updates title if title box is filled out
    if params[:manga][:title] != ""
      @book.title = params[:manga][:title].split.map(&:capitalize).join(' ')
    end
    #Updates volume if volume box is filled out
    if params[:manga][:volume] != ""
    @book.volume = params[:manga][:volume]
    end
    #If both are authors filled, redirects
    if author != "" && params[:manga][:author_id] != nil
      redirect '/manga/new'
    #If top is filled out, but author exists, it assigns existing author
    elsif author != "" && Author.check(author)
      @book.author = Author.find_by(name: author)
    #If top is filled out and author doesn't exist, it assigns top
    elsif author != ""
      @book.author = Author.create(name: author)
    else
      nil
    #If top isn't filled out, it assigns bottom
    end
    if params[:manga][:author_id] != nil
      @book.author = Author.find_by(id: params[:manga][:author_id])
    end
    #First, we clear the genres array
    @book.genres.delete_all
    #If top is filled out, but genre exists, it assigns existing genre
    if genre != "" && Genre.check(genre)
      @book.genres << Genre.find_by(name: genre)
    #If top is filled out and genre doesn't exist, it assigns top
    elsif genre != ""
      @book.genres << Genre.create(name: genre)
    #No matter what, it assigns bottom
    else
    end
    if params[:manga][:genre_ids] != nil
      params[:manga][:genre_ids].each do |id|
        @book.genres << Genre.find_by(id: id)
      end
    else
      @book.genres = []
    end

  @book.save
    erb :'/book/book'
  end

  delete '/manga/:id' do
    @book = Book.find_by(id: params[:id])
    @book.delete
    redirect '/manga'
  end
end
