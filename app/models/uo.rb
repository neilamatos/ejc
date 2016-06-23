class Uo < ActiveRecord::Base
  belongs_to :estado
  belongs_to :cidade

  validates :nome, presence: true
  validates :sigla, presence: true
  validates :codigo_ug, presence: true
  validates :cnpj, presence: true
  
  def to_s
    self.nome
  end
end
