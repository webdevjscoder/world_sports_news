class UsersController < ApplicationController
# goal is to use 7 RESTful routes

    # renders signup form
    get '/signup' do
        if logged_in?
            erb :'users/homepage'
        else
            erb :'users/signup'
        end
    end

    # creates a new user
    post '/signup' do
        user = User.create(params[:user])
        if user
            redirect to "/homepage/#{user.id}"
        else
            erb :'users/signup'
        end
    end

    # renders login form
    get '/login' do
        if logged_in?
            erb :'users/homepage'
        else
            erb :'users/login'
        end
    end

    # verifies the user's login via their password
    post '/login' do
        user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
        if user != false
            session[:user_id] = user.id
            redirect to "/homepage/#{user.id}"
        else
            erb :'users/login'
        end
    end

    # adds team to the current user
    post '/add_team' do
        user_teams = []
        user = User.find_by_id(current_user.id)
        existing_teams = user.teams.where("user_id == #{current_user.id}")
        params[:team_ids].each do |team_id|
            if !existing_teams.exists?(team_id)
                user_teams << UserTeam.create(user_id: current_user.id, team_id: team_id.to_i)
            else
                user_teams
            end
        end
        redirect to "/homepage/#{current_user.id}"
    end

    # shows user homepage when they login or create and account
    get '/homepage/:id' do
        if logged_in?
            user = User.find_by_id(current_user.id)
            @user_teams = user.teams.where("user_id == #{current_user.id}")
            erb :"users/homepage"
        else
            erb :"users/login"
        end
    end

    # allow user to exit their own information
    get '/homepage/:id/edit' do
        if !logged_in?
            erb :'users/login'
        else
            if user = User.find_by(current_user.id)
                erb :'users/edit'
            else
                erb :'users/homepage'
            end
        end
    end

    put '/homepage/:id' do
        user = User.find_by_id(params[:id])
        user.update(params[:user])
        redirect to "/homepage/#{user.id}"
    end

    delete '/homepage/:id' do
        user = User.find_by_id(params[:id])
        session.clear
        user.destroy
        redirect to "/"
    end

    # logs out the user
    get '/logout' do
        session.clear
        erb :'index.html'
    end
    
end