class CreateEncontros < ActiveRecord::Migration[5.1]
  def change
    create_table :encontros do |t|
      t.string :descricao
      t.string :tema
      t.string :local
      t.string :data

      t.timestamps
    end
  end
end
