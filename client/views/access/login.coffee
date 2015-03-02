Template.login.createAccount = -> Session.get('createAccount')


# Template.login.events
# 	'submit form': (e, t) ->
# 		username = t.find('#username').value
# 		password = CryptoJS.MD5(t.find('#password').value).toString()
# 		Meteor.loginWithPassword username, password

# loginForm
# Control de los eventos del formulario de la
# identificación del usuario

Template.loginForm.events

	# login
	# Identificación del usuario.
	'click #login': (e, t) ->
		e.preventDefault()
		console.log 'login'
		username = t.find('#username').value
		password = CryptoJS.MD5(t.find('#password').value).toString()

		Meteor.loginWithPassword username, password, (err) ->
			if err
				console.log err
			else
				console.log 'keyup::Backbone->dashboard'
				Backbone.history.navigate '/dashboard', true


	# createAccount
	# Cambia la variable de session createAcccount
	# para mostrar por pantalla el formulario de crear
	# un nuevo usuario
	'click #createAccount': (e, t) ->
		e.preventDefault()
		Session.set 'createAccount', true


# registerForm
# Control de los eventos del formulario de registro de
# usuraios, una vez se muestra el formulario

Template.registerForm.events

	# register
	# Genera un nuevo usuario en la base de datos.
	'click #register': (e, t) ->
		e.preventDefault()
		username = t.find('#username').value
		password = CryptoJS.MD5(t.find('#password').value).toString()
		email = t.find('#email').value
		name = t.find('#name').value

		userData = {"username": username,"password": password,	"email": email,	"profile": {"name": name}}
		console.log(userData)

		# TODO: realizar validación de los datos.
		
		# Generamos el nuevo usuario.
		Accounts.createUser(userData, (err) -> console.log err if err )


	# cancelAccount
 	# Cambia la variable de session para dejar de mostrar
 	# el formulario de crear usuario.
	'click #cancelAccount': (e, t) ->
		e.preventDefault()
		Session.set 'createAccount', false


Template.loginForm.rendered = () ->
	Backbone.history.navigate '/login', true

Template.registerForm.rendered = () ->
	Backbone.history.navigate '/register', true