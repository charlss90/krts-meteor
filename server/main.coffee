Meteor.methods
	addCart: (idProduct) ->
		if loggedIn()
			products = []
			if idProduct
				products.push(Products.find({_id: idProduct})?.fetch()?[0])
			Carts.insert
				products: products
				cretateOn: new Date

	updateCart: (idCart, options) ->
		# En options puede haber una ide de producto o un cliente...
		idProduct = options?.idProduct
		cart = Carts.findOne({_id: idCart})
		if idProduct and cart
			cart.products.push(Products.find({_id:idProduct})?.fetch()?[0])
			delete cart._id
			Carts.update({_id: idCart}, {$set: cart})

	removeProduct: (idCart, idProduct) ->
		cart = Carts.findOne _id: idCart
		products =  Products.findOne _id: idProduct

		if products and cart
			index = cart.products.indexOf(products)
			if index
				cart.products.splice(index, 1)
				delete cart._id
				Carts.update {_id:idCart}, {$set: cart}

	allCategories: () -> 
		if loggedIn()
			console.log 'user'
			cat_find = Categories.find()
			console.log cat_find.fetch()
			return cat_find
		return {err:'errr'}

# publish 
# Elementos que puede tener el
#

Meteor.publish 'products', () -> Products.find()

Meteor.publish 'categories', () -> Categories.find()

Meteor.publish 'carts', () -> Carts.find()

Meteor.publish 'accounts', () -> Accounts.find()

Meteor.publish 'cashes', () -> Cashes.find()