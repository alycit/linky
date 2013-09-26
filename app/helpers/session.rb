def logged_in?
	session[:user_id]
end

def current_user
	@current_user ||= User.find_by_user_id(session[:user_id])
end

def unique_tags_for_user
	current_user.tags.order("text").uniq
end
