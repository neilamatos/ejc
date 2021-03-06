class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :uo

  attr_accessor :password_string

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false
  validates :nome, presence: true, length: { in: 3..255 }
  validates :telefone, phone: { mobile: false }
  validates :role_id, presence: true

  # Removing email uniqueness validation
  def email_changed?
    false
  end

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

  def ldap_before_save
    self.nome = Devise::LDAP::Adapter.get_ldap_param(self.username, "description").first
    role_type = Devise::LDAP::Adapter.get_ldap_param(self.username, "extensionAttribute2").first.force_encoding("UTF-8")
    if role_type == "Técnico-Administrativo"
      puts "Criando Servidor"
    end
    self.role_id = 1
  end
end
