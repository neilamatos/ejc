class AddNomePessoaToServico < ActiveRecord::Migration[5.1]
  def change
    add_column :servicos, :nome_pessoa, :string
  end
end
