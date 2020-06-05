class UsersRole < ActiveRecord::Base
    belongs_to :user
    has_many :roles
end