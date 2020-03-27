class Equipe < ApplicationRecord
  has_many :equipe_funcoes, dependent: :destroy
  accepts_nested_attributes_for :equipe_funcoes, allow_destroy: true
end
