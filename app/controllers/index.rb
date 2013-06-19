get '/' do
  erb :index
end

get '/sign_in' do
  redirect auth_code_url
end

get '/oauth2callback' do
  @access_token = request_token(params["code"])

  response = @access_token.get('https://www.googleapis.com/plus/v1/people/me')

  profile_info = JSON.parse(response.body)
  @image_url = profile_info["image"]["url"]
  @name = profile_info["displayName"]
  @organizations_array = profile_info["organizations"]
  @places_lived_array = profile_info["placesLived"]

  session.delete(:request_token)

  erb :index
end

get '/sign_out' do
  session.clear
  redirect '/'
end
