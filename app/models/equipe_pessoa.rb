class EquipePessoa < ApplicationRecord
  belongs_to :pessoa
  belongs_to :equipe
end
