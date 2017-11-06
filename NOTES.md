#THINGS HAVEN'T DONE - and won't do: make sure there isn't an instance of that same book

#THINGS STILL TO DO -
#Must still make edits in order to put books into an actual user's account!
#Must make author pages
#Must make genre pages
#Show books in account
#must be able to edit a specific book page and a specific account page
#Must put a link to each page on every list
#make sure that if volume is already existing, it links to that book's homepage
#make a book homepage that you can edit
#later must make a user page you can edit with the books in your collection
#must be able to add and delete books on that same edit page (Look back at that figure/landmark assignment)

users

id| username | email | password digest|

books

id| title | volume | author_id

genres

id | name

user_books

user_id | book_id

book_genres

book_id | genre_id

authors

id | name

Sign Up Params:
user => {username => Harry, email=>harry@hogwarts.edu, password=>hedwig}

Login Params:
user => {username => Harry, email=>harry@hogwarts.edu, password=>hedwig}

New Manga Params:
manga => {title => Fruits Basket, volume=>1, author=>Natsuki Takaya, author_id: 2, Genre: Shoujo, genre_ids => [#, #]}

get '/users/:id'
  #THINGS TO BE DONE:
  #[X] profile pg can only be seen when logged in
  #[X] profile pg can only be seen if person logged in is the user of that profile page
  #[X]create a functioning logout button

post '/manga'

  #[X] make sure that if someone types in an author, they check to see if the author is already there, and if so, they use that author
  #[X] make sure that if someone clicks an author and types one in, it reloads the form
