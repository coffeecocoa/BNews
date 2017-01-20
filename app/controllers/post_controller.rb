class PostsController < ApplicationController
	get '/submit' do
	  redirect_if_not_logged_in
	  @error_message = params[:error]
	  if current_user 
	    erb :submit
	  else
	    redirect '/login'
	  end
	end

	post "/submit" do
		redirect_if_not_logged_in
		@error_message = params[:error]
		post = Post.create(params[:form])
		post.user = current_user
		if post.save
			redirect "/"
		else
			redirect "/submit?error=invalid post"
		end
	end

	#vote 
	get "/vote/:id" do
		@post = Post.find(params[:id])
		@post.increment!(:points)
		redirect "/"
	end

	get "/downvote/:id" do
		@post = Post.find(params[:id])
		@post.decrement!(:points)
		redirect "/"
	end

end
