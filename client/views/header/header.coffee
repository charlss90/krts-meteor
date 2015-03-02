
Template.header.loggedIn = () -> loggedIn()

Template.header.username = () -> Meteor.user()?.username


Template.header.events
	'click #options': (e, t) ->
		e.preventDefault()
		console.log 'clicked options'

	'click #logout': (e, t) ->
		e.preventDefault()
		Meteor.logout()

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