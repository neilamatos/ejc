class AddUoToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :uo, index: true, foreign_key: true
  end
end
