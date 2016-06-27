class Permission < ActiveRecord::Base
  has_and_belongs_to_many :role

  validates :subject_class, presence: true, length: { in: 2..255 }
  validates :action, presence: true, length: { in: 2..255 }

  def to_s
    name = "#{self.subject_class} - #{self.nome}"
    name = "#{self.controller_namespace}::#{name}" if !self.controller_namespace.blank?
    name
  end
end
