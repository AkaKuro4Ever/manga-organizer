users

id| username | email | password digest|

books

id| title | author | genre

user_books

user_id | book_id

Sign Up Params:
user => {username => Harry, email=>harry@hogwarts.edu, password=>hedwig}
Login Params:
user => {username => Harry, email=>harry@hogwarts.edu, password=>hedwig}

get '/users/:id'
  #THINGS TO BE DONE:
  #[X] profile pg can only be seen when logged in
  #[X] profile pg can only be seen if person logged in is the user of that profile page
  #[X]create a functioning logout button
