class CreateServicos < ActiveRecord::Migration[5.1]
  def change
    create_table :servicos do |t|
      t.references :pessoa, foreign_key: true
      t.references :encontro, foreign_key: true
      t.references :equipe_funcao, foreign_key: true

      t.timestamps
    end
  end
end
