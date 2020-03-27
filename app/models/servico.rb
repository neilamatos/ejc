class Servico < ApplicationRecord
  belongs_to :pessoa
  belongs_to :encontro
  belongs_to :equipe_funcao
end
