class Uo < ActiveRecord::Base
  belongs_to :estado
  belongs_to :cidade

  validates :nome, presence: true
  validates :sigla, presence: true

  def to_s
    self.nome
  end
end
