class CreateEquipesPessoas < ActiveRecord::Migration[5.1]
  def change
    create_table :equipes_pessoas do |t|
      t.references :pessoa, foreign_key: true
      t.references :equipe, foreign_key: true

      t.timestamps
    end
  end
end
