class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:users, :avatar)
      add_column :users, :avatar, :string
    end
    unless column_exists?(:users, :name)
      add_column :users, :name, :string
    end
    add_column :users, :bio, :text
  end
end