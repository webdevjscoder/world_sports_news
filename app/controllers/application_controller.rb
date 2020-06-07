require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, 'teams'
    end

    # renders the welcome page where user either logs in or signs up
    get '/' do
        @teams = Team.all
        @team_comments = TeamComment.all
        erb :'users/homepage', :layout => :homepage_screen
    end

    helpers do
        
        # checks to see if user is logged in
        def logged_in?
            !!current_user
        end

        # sets current_user
        def current_user
             @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end
    end 

end