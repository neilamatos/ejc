class CreateHabilidades < ActiveRecord::Migration[5.1]
  def change
    create_table :habilidades do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
