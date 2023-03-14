a user can write multiple  post
post can have many comments
comments can have replies 

User
id
username 
email

Userpost
user_id
post_id

Post 
title 
description

Comments
comment
post_id
user_id


Reply
comment_id
reply
user_id


user has_many :posts

MongoDB

Post 
user_id

Comments
post_id
user_id
reply





