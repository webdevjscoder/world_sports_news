class CommentsController < ApplicationController

    post '/comments' do
        if logged_in?
            if !params[:comment]
                comment = Comment.create(content: params[:comment], user_id: current_user.id)
                commented_team = params[:team_id].to_i
                @team_comment = TeamComment.create(team_id: commented_team, comment_id: comment.id)
                redirect to "/profile/#{current_user.id}"
            else
                redirect to "/profile/#{current_user.id}"
            end
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end

    get '/comments/:id/edit' do
        if logged_in?
            @comment_to_edit_id = TeamComment.find_by_id(params[:id]).comment.id
            @comment_to_edit = current_user.comments.find_by_id(@comment_to_edit_id).content
            erb :'comments/edit_comment'
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end

    put '/comments/:id' do
        if logged_in?
            updated_comment = current_user.comments.find_by_id(params[:comment_id])
            updated_comment.update(content: params[:comment])
            redirect to "/profile/#{current_user.id}"
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end

    delete '/comments/:id/delete' do
        if logged_in?
            @team_comments = TeamComment.all
            TeamComment.delete(@team_comments.find_by_id([params[:id].to_i]))
            redirect to "/profile/#{current_user.id}"
        else
            erb :'users/login', :layout => :homepage_screen
        end
    end
end