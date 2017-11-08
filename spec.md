# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
  Sinatra::Base used in ApplicationController & was inherited to all other classes

- [X] Use ActiveRecord for storing information in a database
  Rake and ActiveRecord used for all migrations

- [X] Include more than one model class (list of model class names e.g. User, Post, Category)

We have 6 model classes, 2 are join tables, 4 are objects that can be instantiated: Book, Author, Genre, and User.

- [X] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
  Author has many genres & books
  Book has many user-books, users, book_genres, & genres
  Genre has many book_genres, books, and authors
  User has many user_books and books
- [X] Include user accounts
  Done through the user controller and signup sheet, which instantiates new objects and saves them to DB

- [X] Ensure that users can't modify content created by other users
  Checked through get '/users/:id' and the current_user method to see if current_user is the creator of the profile page being accessed

- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  Other than the join tables, the Book belongs to authors. It has the ability to be deleted in the delete '/manga/:id/delete' route.

- [X] Include user input validations
  '/manga/edit/:id'
  '/manga/new'
  'signup'
  and 'login' routes are prime examples of validations for all combinations of inputs, as well as authenticating passwords

- [X] Display validation failures to user with error message (example form URL e.g. /posts/new)
  3 errors will pop up, depending on signup, login, or new manga creation errors

- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [X] You have a large number of small Git commits
- [X] Your commit messages are meaningful
- [X] You made the changes in a commit that relate to the commit message
- [X] You don't include changes in a commit that aren't related to the commit message
