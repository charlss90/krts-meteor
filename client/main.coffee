Meteor.subscribe 'products'
Meteor.subscribe 'categories'
Meteor.subscribe 'carts'
Meteor.subscribe 'accounts'
Meteor.subscribe 'cashes'

verifyLogin = (callback) ->
	if Meteor.user()
		callback()
	else
		Backbone.history.navigate '/login', true

showSearch = (query) ->
	
	search = Products.find({ name:{$regex: query }}).fetch()
	Session.set('searchCtrl', search)

	if not Session.get showSearch
		Session.set('showSearch', true)

hideSearch = () ->
	if Session.get 'showSearch'
		Session.set 'slideProductsSearch', false
		move = $('#search-dash').width() - $('#search-dash').css('margin-left')?.split?('p')[0]
		$('#search-dash').animate {"left": move}, 200, () ->
			Session.set('showSearch', false)
			Session.set('searchCtrl', [])
		$('#search').val('')
		if Session.get 'showCategoryProducts'
			$('.page-wrapper .search-dash').animate({'left': 0}, 200)
	if Session.get 'showCategoryProducts'
		move = $('.page-wrapper .search-dash').width() - $('.page-wrapper .search-dash').css('margin-left').split('p')[0]
		$('.page-wrapper .search-dash').animate {"left": move}, 200, () ->
			Session.set 'showCategoryProducts', false
			Session.set 'slideProducts', false
			Session.set 'categoryProducts', []

@KratosRouter = Backbone.Router.extend
	routes: {
		"": "main"
		"login": "login"
		"dashboard": "dashboard"
		"dashboard/search": "search"
		"dashboard/search/:query" : "search"
		"dashboard/category/:query": "category"
		"register": "register"
	}
	login: () ->
		console.log 'loginRouter'
		verifyLogin () ->
			Barckbone.history.navigate '/dashboard', true

	main: () ->
		console.log 'mainRouter'
		verifyLogin () ->
			Backbone.history.navigate '/dashboard', true
	
	dashboard: () ->
		console.log 'dashboardRouter'

		verifyLogin () ->
			console.log 'showdashboard'
			hideSearch()

	register: () ->
		console.log 'registerRouter'
		verifyLogin () ->
			Backbone.history.navigate '/dashboard', true
		
	search: (query, page) ->
		console.log 'searchRouter'
		verifyLogin () ->
			console.debug 'query', query
			if not query
				Barckbone.history.navigate '/dashboard', true
			else
				showSearch(query)

	category: (query, page) ->
		console.log 'categoryRouter'
		verifyLogin () ->
			if not query
				console.log 'categoryRouter::Backbone->dashboard'
				Backbone.history.navigate '/dashboard', true
			else
				if Session.get 'showCategoryProducts'
					if Session.get 'showSearch'
						move = $('#search-dash').width() - $('#search-dash').css('margin-left')?.split?('p')[0]
						$('#search-dash').animate {"left": move}, 200, () ->
							Session.set('showSearch', false)
							Session.set('searchCtrl', [])
						$('#search').val('')
					$('.page-wrapper .search-dash').animate({'left': 0}, 200)
				else	
					Session.set 'showCategoryProducts', query
					Session.set 'categoryProducts', Products.find({category:query}).fetch()





Meteor.startup ()->
	new KratosRouter
	Backbone.history.start pushState: true