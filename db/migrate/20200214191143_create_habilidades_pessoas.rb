class CreateHabilidadesPessoas < ActiveRecord::Migration[5.1]
  def change
    create_table :habilidades_pessoas do |t|
      t.references :pessoa, foreign_key: true
      t.references :habilidade, foreign_key: true

      t.timestamps
    end
  end
end
