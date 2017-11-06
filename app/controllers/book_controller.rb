class BookController < ApplicationController

  get '/manga/new' do

    erb :new
  end

  post '/manga' do
    #make sure that if volume is already existing, it links to that book's homepage

    #make a book homepage that you can edit
    #later must make a user page you can edit with the books in your collection
    #must be able to add and delete books on that same edit page (Look back at that figure/landmark assignment)
    #make sure that if someone types in an author, they check to see if the author is already there, and if so, they use that author
    #[X] make sure that if someone clicks an author and types one in, it reloads the form
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
    # binding.pry
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
    binding.pry
    erb :book
  end
end
