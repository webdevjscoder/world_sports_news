class Comment < ActiveRecord::Base
    belongs_to :user
    has_many :team_comments
    has_many :teams, through: :team_comments
end