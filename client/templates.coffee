
# @ifViewing = (viewName) -> Session.get('currentView') is viewName;


# Template.header.adminLoggedIn = () -> adminLoggedIn()


# Template.header.events
# 	'click button': () -> Backbone.history.navigate('/new-post', true);
	

# Template.newPostForm.show = () -> ifViewing('newPostForm')


# Template.newPostForm.events
# 	'keyup #title': (e, t) -> t.find("#slug").value = t.find("#title").value.toLowerCase().split(' ').join('-');

# 	'click button': (e, t) ->
# 		slug = t.find("#slug").value
# 		content = t.find('#content').value
# 		title = t.find("#title").value

# 		Meteor.call 'post', content, title, slug, (err, id) ->
# 			if err
# 				console.log err
# 			else
# 				console.log id

# Template.posts.show = () -> (ifViewing("posts") or ifViewing("post"))


# Template.posts.posts = () ->
# 	if ifViewing 'posts'
# 		Posts.find {}, {sort: { createdOn: -1 }}
# 	else
# 		Posts.find {}, {sort: {createdOn: -1}}