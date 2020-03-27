class CreateEquipes < ActiveRecord::Migration[5.1]
  def change
    create_table :equipes do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
