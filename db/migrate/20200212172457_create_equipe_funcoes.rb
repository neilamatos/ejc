class CreateEquipeFuncoes < ActiveRecord::Migration[5.1]
  def change
    create_table :equipe_funcoes do |t|
      t.references :equipe, foreign_key: true
      t.references :funcao, foreign_key: true
      t.references :tipo, foreign_key: true
      t.integer :minimo
      t.integer :maximo

      t.timestamps
    end
  end
end
