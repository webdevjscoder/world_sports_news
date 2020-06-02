class AddIndex < ActiveRecord::Migration
  def change
    add_index :user_teams, [:user_id, :team_id], unique: true
  end
end
