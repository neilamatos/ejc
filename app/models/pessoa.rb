class Pessoa < ApplicationRecord
  belongs_to :encontro
  belongs_to :circulo
  belongs_to :tipo
  has_many :servicos

  has_and_belongs_to_many :habilidades, :through => :habilidade_pessoas
  accepts_nested_attributes_for :habilidades, :allow_destroy => true

  has_and_belongs_to_many :equipes, :through => :equipe_pessoas
  accepts_nested_attributes_for :equipes, :allow_destroy => true

  # has_many :habilidade_pessoas, class_name:"HabilidadePessoa", dependent: :destroy
  # accepts_nested_attributes_for :habilidade_pessoas, allow_destroy: true
  #
  # has_many :equipe_pessoas, class_name:"EquipePessoa", dependent: :destroy
  # accepts_nested_attributes_for :equipe_pessoas, allow_destroy: true





  validates :nome, presence:true

  def age
    if !self.data_nasc.blank?
      now = Time.now.utc.to_date
      now.year - self.data_nasc.year - ((now.month > self.data_nasc.month || (now.month == self.data_nasc.month && now.day >= self.data_nasc.day)) ? 0 : 1)
    end
  end
end
