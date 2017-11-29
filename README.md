Description

Use this program to keep track of your manga and novels in your library, including what author and genre they are!

Usage

To use this app, just clone, run rake db:migrate and then run shotgun. Everything should be set up.



# New App

Domain

# Models

User
----
email -> must be unique
password -> must be secure
has many manga

Manga
-----
title:String -> must not be blank
description:Text -> must not be blank
author:String -> must not be blank
belongs to a user

# Requirements

- A user must be logged in to create, update or destroy a manga
- Only the user who created the manga can update, destroy or view the edit form
