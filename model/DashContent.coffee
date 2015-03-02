@DashContent = class DashContent
	constructor: (@content) ->
		@deps = new Deps.Dependency

	set: (content) ->
		console.log content
		@content = content
		@deps.changed()

	get: () -> 
		if @content
			console.log @content.fetch()
		@deps.depend()
		@content