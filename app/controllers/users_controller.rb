class UsersController < ApplicationController
# goal is to use 7 RESTful routes

    # renders login form
    get '/login' do
        erb :'users/login'
    end

    # renders signup form
    get '/signup/new' do
        erb :'users/signup'
    end

    # creates a new user
    post '/signup' do
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:id] = @user.id
            redirect to "/teams"
    end

    # shows user homepage when they login or create and account
    get '/homepage/:id' do
        @user = User.find_by(params[:id])
        erb :"users/homepage"
    end

    # verifies the user's login via their password
    post '/homepage' do
        @user = User.find_by(params[:id])
        if @user != "" && @user.authenticate(params[:password])
            redirect to "/homepage/#{@user.id}"
        else
            redirect to '/login'
        end
    end



    get '/logout' do
        session.clear
        erb :'index.html'
    end
    

end