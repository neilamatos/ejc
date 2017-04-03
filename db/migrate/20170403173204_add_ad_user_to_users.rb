class AddAdUserToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ad_user, :boolean, default: false
  end
end
