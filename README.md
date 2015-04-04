# TodoWiz API [![Build Status](https://travis-ci.org/karimmtarek/todo-wiz.svg?branch=master)](https://travis-ci.org/karimmtarek/todo-wiz)
External Todo API with authentication.

### Use case
A simple API that any programmer can easily navigate and extend. Can be interacted with easily from the command line.

### User stories
1. As a user, I want to be able to create new user from the command line using and email/password.
2. As a user, I want to be able to authenticate myself from the command line, using an authentication token.
3. As a user, I want to be able to create new lists from the command line.
4. As a user, I want to be able to create new todo items from the command line.
5. As a user, I want to be able to change list permissions from the command line.
6. As a user, I want to be able to remove lists from the command line.
7. As a user, I should be able to view any list with permissions set to viewable or public, from the command line.
8. As a user, I should be able to edit any lists with permissions set to public from the command line.
9. As a user, I should receive an error when I attempt to set an unsupported permission from the command line.
10. As a user, I shouldn't be able to delete any lists with permissions set to viewable/private from the command line.
11. As a user, I want to be to delete my account.
12. As a user, I can't delete other users accounts.
13. As a user, I want to be able to add and remove items from lists, using the command line.
14. As a user, I want to be able to mark items as completed, using the command line.
### Setup
1. Open your terminal, clone this repository `git clone git@github.com:karimmtarek/todo-wiz.git todowiz_api_testdrive`
2. Change directory to todowiz application directory `cd todowiz_api_testdrive`
3. Run `bundle install`
4. Run `rake db:migrate`
5. Run `rails server`
6. You are good to go, follow the steps in 'How to use' for more information.

### How to test drive the API in your terminal using Curl
#####Create new user
```
curl -d "user[email]=user@example.com" -d "user[password]=password" http://localhost:3000/v1/users
```
> If entered a valid email/password combination you'll get a token, you need to use this token in any other operation to authinticate the request.

#####Create new todo list
```
curl -H 'Authorization: Token token="d5384770d8b7f5aaadfbbcb3"' -d "list[name]=my first todo list" -d "list[permission]=private" http://localhost:3000/v1/lists
```

> make sure the the token is surrounded with "double quotes"

#####Update todo list
```
curl -H 'Authorization: Token token="d5384770d8b7f5aaadfbbcb3"' -d "list[name]=my first todo list - updated" -X PUT http://localhost:3000/v1/lists/1
```

#####Create new todo item
```
curl -H 'Authorization: Token token="d5384770d8b7f5aaadfbbcb3"' -d "item[name]=my first todo item" http://localhost:3000/v1/lists/1/items
```

#####Update todo item
```
curl -H 'Authorization: Token token="d5384770d8b7f5aaadfbbcb3"' -d "item[name]=my first todo item - updated" -X PUT http://localhost:3000/v1/lists/1/items/1
```

#####Delete todo item
```
curl -H 'Authorization: Token token="d5384770d8b7f5aaadfbbcb3"' -X DELETE http://localhost:3000/v1/lists/1/items/1
```
#####Delete todo list
```
curl -H 'Authorization: Token token="d5384770d8b7f5aaadfbbcb3"' -X DELETE http://localhost:3000/v1/lists/1
```

#####Delete user
```
curl -H 'Authorization: Token token="d5384770d8b7f5aaadfbbcb3"' -X DELETE http://localhost:3000/v1/users/1
```
