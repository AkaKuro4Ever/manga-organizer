class BookController < ApplicationController

  get '/manga/new' do

    erb :'/book/new'
  end

  get '/manga' do

    erb :'/book/manga'
  end

  post '/manga' do
    author = params[:manga][:author].strip.split.map(&:capitalize).join(' ')
    genre = params[:manga][:genre].strip.split.map(&:capitalize).join(' ')

    if params[:manga][:title] != ""
      @book = Book.new(title: params[:manga][:title].split.map(&:capitalize).join(' '), volume: params[:manga][:volume])
    end
    #If both are authors filled, redirects
    #If title is not filled out, redirects
    #If both genres filled out, redirects
    if author != "" && params[:manga][:author_id] != nil || genre != "" && params[:manga][:genre_ids] != nil || params[:manga][:title] == ""
      redirect '/manga/new'
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
    else
      if params[:manga][:genre_ids] != nil
        params[:manga][:genre_ids].each do |id|
          @book.genres << Genre.find_by(id: id)
        end
      end
    end

  @book.save
    if logged_in?
      current_user.books << @book
    end
    @user = current_user
    erb :'/book/book'
  end

  get '/manga/:id' do

    @book = Book.find_by(id: params[:id])
    erb :'/book/book'
  end

  get '/authors/:id' do

    @author = Author.find_by(id: params[:id])

    erb :'/book/author'
  end

  get '/genres/:id' do

    @genre = Genre.find_by(id: params[:id])

    erb :genre
  end

  get '/manga/add/:id' do
    @book = Book.find_by(id: params[:id])
    current_user.books << @book
    redirect to "users/#{current_user.id}"
  end

  get '/manga/edit' do

    erb :'book/edit'
  end
end
