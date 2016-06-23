class Cidade < ActiveRecord::Base
  belongs_to :estado

  def to_s
    self.nome
  end
end
