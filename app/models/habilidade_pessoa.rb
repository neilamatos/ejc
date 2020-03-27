class HabilidadePessoa < ApplicationRecord
  belongs_to :pessoa
  belongs_to :habilidade
end
