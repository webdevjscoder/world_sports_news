class Team < ActiveRecord::Base
    has_many :user_teams
    has_many :users, through: :user_teams 
    has_many :team_comments
    has_many :comments, through: :team_comments
end