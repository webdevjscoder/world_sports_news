class TeamsController < ApplicationController

    # shows all the teams
    get '/teams' do
        # @user = User.find_by(params[:id])
        @teams = Team.all
        erb :'teams/index'
    end

end