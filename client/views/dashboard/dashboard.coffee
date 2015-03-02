###############################################################################
# Cart Controller
# En este apartado controlamos todo lo que tiene que ver con el control
# del carro de la compra
##################################################################################

Template.Cart.products = () ->
	console.debug 'Cart::products'
	if Session.get 'cartActivate'
		cart =  Carts.findOne(_id:Session.get('cartActivate'))
		if cart
			cart.products
		else
			[]
	else
		[]

@addProduct = (id) ->
	if not Session.get('cartActivate')
		Meteor.call 'addCart', id, (err, idCart) ->
			Session.set('cartActivate', idCart)
	else
		Meteor.call 'updateCart', Session.get('cartActivate'), {idProduct: id}, (err, idCart) ->
			if err
				console.log err
			else
				console.log idCart

Template.Cart.totalCart = () ->
	console.debug 'Cart::totalCart'
	
	cart = Carts.findOne(_id:Session.get('cartActivate'))

	# verificación de los products
	products = if cart?.products.length then cart.products else null


	if products
		(product.basePrice for product in products).reduce (t, s) -> t + s
	else
		0.00


Template.productCart.events

	# removeProduct
	# Elimina el producto del carro a partir del cart
	'click .removeProduct': (e, t) ->
		e.preventDefault()
		console.debug 'productCart::click .removeProduct'
		if Session.get 'cartActivate'
			Meteor.call 'removeProduct', Session.get('cartActivate'), @_id, (err, idProduct) ->
				if err
					console.log err
				else
					console.log idProduct


##################################################################################
# Search Controller
# En este apartado controlamos todo lo que tiene que ver con el control
# de la busqueda del producto
##################################################################################

Template.categoryDash.categories = () -> Categories.find()

Template.category.events
	# evento que controla el box-category,
	# contiene tanto las categorias como los productos que puedan haber
	# TODO: pendiente de cambiar el nombre a un nombre más general,
	'click .box-category': (e, t) ->
		# preventDefault: lo ponemos por si acaso.
		console.debug 'categoryDash::click .box-category'
		e.preventDefault()
		if not @basePrice
			Backbone.history.navigate '/dashboard/category/' + @name, true
		else
			addProduct(@_id)


Template.productSearch.events
	# Control del evento que quita la busqueda
	# al dar un click a la area transparente de la izquierda
	'click .transparent': (e, t) ->
		console.debug 'productSearch::click .transparent'
		search = $('#search-dash')
		console.log 'click.transparet::Backbone->dashboard'

		if Session.get('showCategoryProducts')
			Backbone.history.navigate '/dashboard/category/'+Session.get('showCategoryProducts'), true
		else
			Backbone.history.navigate '/dashboard', true


	# Control del buscador, evento que detecta si se levanta
	# una tecla en el input de busqueda
	'keyup #search': (e, t) ->
		console.debug 'productSearch::click #search'
		# recogemos el valor del input
		query = t.find('input').value
		divSearch = $('#search-dash')

		if query
			console.debug 'backbone router search'
			# hacemos la busqueda en la base de datos
			Backbone.history.navigate '/dashboard/search/'+query.toString(), true
		else
			console.log 'keyup::Backbone->dashboard'
			Backbone.history.navigate '/dashboard', true


Template.categoryProducts.events
	# Control de eventos que quita el categoryProducts dash
	# al hacer un click en la area transparente de la izquierda
	'click .transparent-product': (e, t) ->
		console.debug 'categoryProducts::click .transparent-product'
		Backbone.history.navigate '/dashboard', true



# productDash Rendered
# Evento que se ejecuta al mostrar por pantalla o al realizar
# algun cambio que afecte a la renderización de nuestro template
# Este template muestra la lista de productos resultado de realizar
# una busqueda.
Template.productDash.rendered = () ->
	console.debug 'productDash::rendered'

	if not Session.get 'slideProductsSearch'
		# declaración de los divs
		searchDash = @find('#search-dash')
		transparent = @find('.transparent')
		translation = $(searchDash).css('margin-left').split('p')[0]*-1

		widthDash = $(searchDash).width() * -1	
		Session.set 'slideProductsSearch', true
		# movimiento de los divs
		$(searchDash).css('right', widthDash+100)	

		if Session.get 'showCategoryProducts'
			move = $('.page-wrapper .search-dash').css('margin-left')?.split('p')?[0]
			$('.page-wrapper .search-dash').animate({'left': move*-1}, 200)
		$(searchDash).animate {"right": translation}, 200


# categoryProducts Rendered
#
#
#

Template.categoryProducts.rendered = () ->
	console.debug 'categoryProducts::rendered'
	searchDash = @find('.search-dash')
	transparent = @find('.transparent')

	if not Session.get 'slideProducts'
		Session.set 'slideProducts', true
		translation = $(searchDash).css('margin-left').split('p')[0]*-1
		widthDash = $(searchDash).width() * -1	

		$(searchDash).css('right', widthDash+200)	
		$(searchDash).animate {"right": translation}, 200

Template.categoryDash.showCategoryProducts = () -> Session.get 'showCategoryProducts'

Template.categoryProducts.products = () -> Session.get 'categoryProducts'

Template.productSearch.show_search = () -> Session.get('showSearch')

Template.productDash.products = () -> Session.get('searchCtrl')


Template.dashboard.rendered = () ->
	if not Session.get('showSearch') and not Session.get('showCategoryProducts')
		Backbone.history.navigate 'dashboard', true

