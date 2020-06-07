class TeamComment < ActiveRecord::Base
    belongs_to :team
    belongs_to :comment
end