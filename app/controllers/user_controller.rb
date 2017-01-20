class UsersController < ApplicationController

  #show user 
  get "/users/:id" do
    if !logged_in?
      redirect "/"
    end

    @user = User.find(params[:id])
    if @user == current_user && !@user.nil?
      erb :"/users/show"
    else
      redirect "/"
    end
  end

  #signup
  get "/signup" do
    if !session[:user_id]
      erb :"/users/new"
    else
      redirect "/"
    end
  end

  post "/signup" do
    if params[:user_name] == "" || params[:password] == ""
      redirect "/signup"
    else
      @user = User.create(username: params[:username],
                          password: params[:password])
      session[:user_id] = @user.id
      redirect "/"
    end
  end

  #login
  get "/login" do
    @error_message = params[:error]
    if !session[:user_id]
      erb :"/users/login"
    else
      redirect "/"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/"
    else
      redirect "/signup"
    end
  end

  get "/logout" do
    if session[:user_id] != nil
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
end
