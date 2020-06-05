class UsersController < ApplicationController
# goal is to use 7 RESTful routes

    # renders signup form
    get '/signup' do
        if logged_in?
            erb :'users/profile'
        else
            erb :'users/signup', :layout => :homepage_screen
        end
    end

    get '/admin/signup' do
        if logged_in?
            erb :'users/admin', :layout => :admin_screen
        else
            erb :'users/admin_signup', :layout => :homepage_screen
        end
    end

    post '/admin/signup' do
        user = User.create(first_name: params[:user][:first_name], last_name: params[:user][:last_name], email: params[:user][:email], password: params[:user][:password])
        user_role = Role.create(role_name: params[:user][:role])
        users_role = UsersRole.create(user_id: user.id, role_id: user_role.id)
        if users_role
            session[:id] = user.id
            @user_first_name = params[:user][:first_name]
            binding.pry
            erb :"users/admin", :layout => :admin_screen
        else
            erb :'users/admin_signup', :layout => :homepage_screen
        end
    end

    get '/admin/profile' do
        if logged_in?
            user = User.find_by_id(current_user.id)
            binding.pry
            erb :'users/admin', :layout => :admin_screen
        else
            erb :'users/admin_signup', :layout => :homepage_screen
        end
    end

    # creates a new user
    post '/signup' do
        user = User.create(params[:user])
        if user
            redirect to "/profile/#{user.id}"
        else
            erb :'users/signup', :layout => :homepage_screen
        end
    end

    # renders login form
    get '/login' do
        if logged_in?
            erb :'users/profile'
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end

    # verifies the user's login via their password
    post '/login' do
        user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
        if user != false
            session[:user_id] = user.id
            redirect to "/profile/#{user.id}"
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end

    # add team to current user
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
        redirect to "/profile/#{current_user.id}"
    end

    get '/admin/profile/:id' do
        binding.pry
        if logged_in?
            user = User.find_by_id(current_user.id)
            binding.pry
            erb :'users/admin', :layout => :admin_screen
        else
            erb :'users/admin_signup', :layout => :homepage_screen
        end
    end

    # shows user homepage when they login or create and account
    get '/profile/:id' do
        if logged_in?
            user = User.find_by_id(current_user.id)
            @user_teams = user.teams.where("user_id == #{current_user.id}")
            erb :"users/profile"
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end

    # allow user to exit their own information
    get '/profile/:id/edit' do
        if !logged_in?
            erb :'users/login', :layout => :homepage_screen
        else
            if user = User.find_by(current_user.id)
                erb :'users/edit'
            else
                erb :'users/profile'
            end
        end
    end

    put '/profile/:id' do
        user = User.find_by_id(params[:id])
        user.update(params[:user])
        redirect to "/profile/#{user.id}"
    end

    delete '/profile/:id' do
        user = User.find_by_id(params[:id])
        session.clear
        user.destroy
        redirect to "/"
    end

    # logs out the user
    get '/logout' do
        session.clear
        @teams = Team.all
        erb :'users/homepage', :layout => :homepage_screen
    end
    
end