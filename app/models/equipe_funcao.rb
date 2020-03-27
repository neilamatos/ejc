class EquipeFuncao < ApplicationRecord
  belongs_to :equipe
  belongs_to :funcao
  belongs_to :tipo

  before_save :setar_descricao

  def setar_descricao
    self.descricao = self.equipe.descricao + ' - ' + self.funcao.descricao
  end

  def juncao
    #{}"#{equipe.descricao} - #{funcao.descricao} - #{tipo.descricao}"
  end
end
