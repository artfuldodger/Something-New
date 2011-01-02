class AddSeenToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :seen, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :seen
  end
end
