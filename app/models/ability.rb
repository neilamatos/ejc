class Ability
  include CanCan::Ability

  def initialize(user, namespace)
    if !user.blank? && !user.role.blank?
      user.role.permissions.each do |permission|
        subject_class = permission.subject_class.constantize rescue nil
        if permission.subject_class == "all" || permission.controller_namespace == "Admin" || permission.subject_class == "Settings" || (namespace.blank? && permission.controller_namespace.blank?) ||
           (!namespace.blank? && permission.controller_namespace == namespace)
          if subject_class.blank?
            can permission.action.to_sym, permission.subject_class.to_sym
          else
            can permission.action.to_sym, subject_class
          end
        end
      end
    end
  end
end