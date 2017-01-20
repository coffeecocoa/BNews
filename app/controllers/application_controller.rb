require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "suuuuperduuuuperseecret"
  end

  get "/" do
    @posts = Post.order("created_at DESC LIMIT 10")
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if session[:user_id]
        @current_user ||= User.find_by_id(session[:user_id])
      end
    end
  end
end
