class CreateTipoEquipista < ActiveRecord::Migration[5.1]
  def change
    create_table :tipo_equipista do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
