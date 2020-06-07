class CommentsController < ApplicationController

    post '/comments' do
        if logged_in?
            comment = Comment.create(content: params[:comment], user_id: current_user.id)
            commented_team = params[:team_id].to_i
            @team_comment = TeamComment.create(team_id: commented_team, comment_id: comment.id)
            redirect to "/"
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end

    delete '/comments/:id/delete' do
        @team_comments = TeamComment.all
        TeamComment.delete(@team_comments.find_by_id([params[:id].to_i]))
        redirect to "/profile/#{current_user.id}"
    end
end