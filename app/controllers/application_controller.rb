require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :seesions
        set :session_secret, 'teams'
    end

    get '/' do
        erb :'index.html'
    end

    helpers do
        
        def logged_in?
            !!current_user
        end

        def current_user
            @current_user ||= User.find_by(session[:user_id])
        end
    end 

end