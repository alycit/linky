get '/' do
  if logged_in?
    @links = Tag.find_links_by_tag_and_user(session[:current_view], current_user.id)
    @tags = current_user.find_unique_tags
  end

  erb :index
end

get '/sign_in' do
  redirect auth_code_url
end

get '/oauth2callback' do
  if session[:user_id].nil?
    access_token = request_token(params["code"])
    response = access_token.get('https://www.googleapis.com/plus/v1/people/me')
    profile_info = JSON.parse(response.body)
    session.delete(:request_token)

    #see if user exists in db.... if not, create them!
    user = User.find_by_user_id(profile_info["id"])

    if user.nil?
      User.create(
      user_id: profile_info["id"],
      display_name: profile_info["displayName"],
      first_name: profile_info["name"]["givenName"],
      last_name: profile_info["name"]["familyName"],
      profile_image: profile_info["image"]["url"])
    end

    session[:user_id] = profile_info["id"]
    session[:current_view] = "all"
  end

  redirect '/'
end

get '/sign_out' do
  session.clear
  redirect '/'
end

post '/add_link' do
  if logged_in?
    response = current_user.add_link_with_tags(params[:url],
                                               escape_html(params[:description]),
                                               parse_tags(params[:tags]))
    response.to_json if response
  end
end

get '/add_link_to_user' do
  @url = params[:url]
  @ids = params[:ids]
  erb :add_link, layout: false
end

post '/save_link' do
  response = User.add_link_with_tags_for_user(params[:id],
                                              params[:url],
                                              escape_html(params[:description]),
                                              parse_tags(params[:tags]))
                                              
  response.to_json if response
end

get '/delete/:id' do
  if logged_in?
    Link.delete(params[:id])
  end

  redirect '/'
end

get '/tag/:tag_name' do
  if logged_in?
    session[:current_view] = params[:tag_name]
  end
  redirect '/'
end