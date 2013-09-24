def oauth_client
  @client ||= OAuth2::Client.new(
    ENV['GOOGLE_KEY'],
    ENV['GOOGLE_SECRET'],
    :site => 'https://accounts.google.com',
    :token_url => '/o/oauth2/token',
    :authorize_url => '/o/oauth2/auth')
end

def auth_code_url
  request.host
  request.port
  oauth_client.auth_code.authorize_url(:redirect_uri => "http://#{generate_url}/oauth2callback",
                                       :scope => "https://www.googleapis.com/auth/plus.login")
end

def generate_url
  return "#{request.host}:#{request.port}" if (request.host == "localhost" || request.host == "127.0.0.1")
  request.host
end

def request_token(auth_code_value)
  if not session[:request_token]
    session[:request_token] = oauth_client.auth_code.get_token(auth_code_value, :redirect_uri => "http://#{generate_url}/oauth2callback")
  end
  session[:request_token]
end
