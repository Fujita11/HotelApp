class AddProfileToUsers < ActiveRecord::Migration[6.1]
  def change
        add_column :users, :avatar, :string unless column_exists?(:users, :avatar)
        add_column :users, :bio, :text unless column_exists?(:users, :bio)
      end
end
