class CreateTeamCommentsJoinTable < ActiveRecord::Migration
  def change
    create_table :team_comments do |t|
      t.integer :team_id
      t.integer :comment_id
    end
  end
end
