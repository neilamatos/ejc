class CreateUos < ActiveRecord::Migration
  def change
    create_table :uos do |t|
      t.string :nome
      t.string :sigla
      t.string :cnpj
      t.string :endereco
      t.string :complemento
      t.string :bairro
      t.references :estado, index: true, foreign_key: true
      t.references :cidade, index: true, foreign_key: true
      t.string :cep
      t.string :codigo_ug
      t.integer :codigo

      t.timestamps null: false
    end
  end
end
