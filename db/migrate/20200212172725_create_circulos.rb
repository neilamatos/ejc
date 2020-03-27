class CreateCirculos < ActiveRecord::Migration[5.1]
  def change
    create_table :circulos do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
