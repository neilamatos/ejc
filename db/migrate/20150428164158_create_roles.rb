class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :nome
      t.boolean :uo_dependent, default: true

      t.timestamps null: false
    end
  end
end
