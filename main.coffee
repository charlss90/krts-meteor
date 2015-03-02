
# Variables que comparten entre servidor y cliente
@Products = new Meteor.Collection 'products'
@Categories = new Meteor.Collection 'categories'
@Carts = new Meteor.Collection 'carts'
@AccountsCompany = new Meteor.Collection 'accounts'
@Cashes = new Meteor.Collection 'cashes'

@dashContent = new DashContent(Categories.find())


# funciones que comparte el cliente y el servidor
@loggedIn = () -> Meteor.user()

# console.log(Accounts)

# Meteor.autorun () ->
# 	Session.set('dashContent', @Categories.find())

if Meteor.isServer

	# console.log(Accounts)
	@AccountsCompany.allow
		insert: () -> true
		update: () -> true
		remove: () -> true

	@Categories.allow
		insert: () -> true
		update: () -> true
		remove: () -> true

	@Products.allow
		insert: () -> true
		update: () -> true
		remove: () -> true