class CreatePessoas < ActiveRecord::Migration[5.1]
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.date :data_nasc
      t.references :encontro, foreign_key: true
      t.references :circulo, foreign_key: true
      t.references :tipo, foreign_key: true
      t.string :endereco
      t.string :bairro
      t.string :telefone_1
      t.string :telefone_2

      t.timestamps
    end
  end
end
