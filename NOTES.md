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
