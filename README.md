README

Blocipedia: A Collaborative Wiki Website

Created by: Dan Helmick

Application Requirements:

1) As a user, I want to sign up for a free account by providing a user name, password and email
by incorporating the Devise gem.
2) As a user, I want to sign in and out of Blocipedia through use of the Devise gem.
3) As a user with a standard account, I want to create, read, update, and delete public wikis
4) As a developer, I want to offer three user roles: admin, standard, or premium. Use of the Pundit Gem
for authorization is required.
5) As a developer, I want to seed the development database automatically with users and wikis. Use the Faker gem
in order to seed both users and wikis to the database.
6) As a user, I want to upgrade my account from a free to a paid plan. Account upgrades are driven through the Stripe gem where a standard user can upgrade their membership to premium via monthly fee. If users are not satisfied with their premium membership, they have the option to 'downgrade' their membership back to standard.
7) As a premium user, I want to create private wikis. This feature allows both premium and admin users to create new private wikis and make public wikis private.
8) As a user, I want to edit wikis using Markdown syntax. The Redcarpet gem is used to accomplish this task.
9) As a premium user, I want to add and remove collaborators for my private wikis
