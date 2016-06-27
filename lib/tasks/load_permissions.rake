namespace 'permissions' do
  desc "Loading all models and their related controller methods in permissions table."
  task(:create => :environment) do
    arr = []
    #load all the controllers
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        #check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*$/ #namescoped controllers
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
          if x =~ /_controller/
            arr << "#{entry.titleize}::#{x.camelize.gsub('.rb', '')}".constantize
          end
        end
      end
    end

    arr.each do |controller|
      if controller.permission
        controller_namespace = get_namespace(controller)
        controller.action_methods.each do |method|
          if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/ #add_user, add_user_info, Add_user, add_User
            name, cancan_action = eval_cancan_action(method)
            write_permission(controller.permission, cancan_action, name, controller_namespace)
          end
        end
      end
    end
  end
end

# Getting the controller namespace
def get_namespace(controller)
  controller_namespace = nil
  controller_name_parts = controller.name.gsub('Controller', '').split('::')
  if controller_name_parts.length > 1
    controller_namespace = controller_name_parts.first
  end
  controller_namespace
end

#this method returns the cancan action for the action passed.
def eval_cancan_action(action)
  case action.to_s
  when "index"
    name = 'listar'
    cancan_action = "index" #let the cancan action be the actual method name
    action_desc = I18n.t :list
  when "new", "create"
    name = 'criar'
    cancan_action = "create"
    action_desc = I18n.t :create
  when "show"
    name = 'exibir'
    cancan_action = "show"
    action_desc = I18n.t :view
  when "edit", "update"
    name = 'editar'
    cancan_action = "update"
    action_desc = I18n.t :update
  when "delete", "destroy"
    name = 'deletar'
    cancan_action = "destroy"
    action_desc = I18n.t :destroy
  else
    name = action.to_s
    cancan_action = action.to_s
    action_desc = "Outra: " < cancan_action
  end
  return name, cancan_action
end

#check if the permission is present else add a new one.
def write_permission(model, cancan_action, name, namespace)
  permission = nil
  if namespace.nil?
    permission = Permission.where(["subject_class = ? and action = ? and controller_namespace IS NULL", model, cancan_action]).first
  else
    permission = Permission.where(["subject_class = ? and action = ? and controller_namespace = ?", model, cancan_action, namespace]).first
  end
  unless permission
    permission = Permission.new
    permission.nome = name
    model_name = model.name rescue nil
    if model_name.blank?
      permission.subject_class = model.to_sym
    else
      permission.subject_class = model_name
    end
    permission.action = cancan_action
    permission.controller_namespace = namespace
    permission.save
  end
end