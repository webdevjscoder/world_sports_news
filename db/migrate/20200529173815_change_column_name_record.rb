class ChangeColumnNameRecord < ActiveRecord::Migration
  def change
    rename_column :teams, :record, :team_record
  end
end
