class AddUoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :uo, index: true, foreign_key: true
  end
end
