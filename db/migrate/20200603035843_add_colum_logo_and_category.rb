class AddColumLogoAndCategory < ActiveRecord::Migration
  def change
    add_column :teams, :logo, :string
    add_column :teams, :category, :string
  end
end
