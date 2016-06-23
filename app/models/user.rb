class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :uo

  attr_accessor :password_string
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :nome, presence: true, length: { in: 3..255 }
  validates :telefone, phone: { mobile: false }

  def admin?
    return false if self.nome.blank?
    self.nome == "Admin"
  end

  def can_delete?(current_user)
    return false if current_user.blank? || self.admin?
    current_user.admin?
  end

  def can_edit?(current_user)
    return false if current_user.blank? || self.admin?
    current_user.admin? || self.id == current_user.id
  end

  def super_admin?
    !self.role.blank? && self.role.nome == "SuperAdmin"
  end

  def local_access?
    !self.role.blank? && self.role.uo_dependent?
  end

  def to_s
    self.nome
  end
end
