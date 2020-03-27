class CreateFuncoes < ActiveRecord::Migration[5.1]
  def change
    create_table :funcoes do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
