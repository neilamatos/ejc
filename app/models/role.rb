class Role < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :permissions

  validates :nome, presence: true, length: { in: 2..255 }, uniqueness: true

  def to_s
    self.nome
  end

  def set_permissions(permissions)
    permissions.each do |id|
      #find the main permission assigned from the UI
      permission = Permission.find(id)
      self.permissions << permission
    end
  end
end
