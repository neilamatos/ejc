class AddDescricaoToEquipeFuncao < ActiveRecord::Migration[5.1]
  def change
    add_column :equipe_funcoes, :descricao, :string
  end
end
