class TeamsController < ApplicationController

    # shows all the teams for user to select from
    get '/teams' do
        @teams = Team.all
        user = User.find_by_id(current_user.id)
        @user_teams = user.teams.where("user_id == #{current_user.id}")
        @selected_ids = []
        @user_teams.each do |team|
            @selected_ids << team.id
        end
        erb :'teams/add_team'
    end

    # allows user to unfollow team(s)
    get '/unfollow-teams' do
        user = User.find_by_id(current_user.id)
        @user_teams = user.teams.where("user_id == #{current_user.id}")
        erb :'teams/remove_team'
    end

<<<<<<< Updated upstream
    # removes teams the user selects
    post '/remove_teams' do
=======
    post '/remove-teams' do
>>>>>>> Stashed changes
        user = User.find_by_id(current_user.id)
        params[:team_ids].each do |team_id|
            team_to_delete = user.teams.where(["user_id = ? and team_id = ?", current_user.id, team_id.to_i])
            user.teams.delete(team_to_delete)
        end
        redirect to "/profile/#{current_user.id}"
    end

end