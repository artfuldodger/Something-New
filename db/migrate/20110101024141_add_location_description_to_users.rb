class AddLocationDescriptionToUsers < ActiveRecord::Migration
  def self.up
		add_column :users, :location, :string
		add_column :users, :reddit, :string
		add_column :users, :description, :text
  end

  def self.down
		remove_column :users, :location
		remove_column :users, :reddit
		remove_column :users, :description
  end
end
