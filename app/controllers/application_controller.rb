class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    resource = controller_path.split('/').last.underscore.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # rescue from the access denied exception from cancan when a certain user doesn't
  # have the permissions to access a resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to session[:return_to] || main_app.root_path, alert: "Você não tem permissão para acessar esta página" or return
  end

  after_filter do
    store_location
  end

  protected

  def unauthorized_local_access(object_uo_id)
    if current_user.local_access? && current_user.uo_id != object_uo_id
      render :file => 'public/404.html', status: 404
      return true
    end
    false
  end

  def unauthorized_access(expression)
    if !expression
      render :file => 'public/404.html', status: 404
      return true
    end
    false
  end

  #derive the model name from the controller. egs UsersController will return User
  def self.permission
    name = self.name.gsub('Controller', '').split('::').last.underscore.singularize.camelize.constantize rescue nil
    if name.blank?
      name = self.name.gsub('Controller', '').split('::').last.underscore.singularize.camelize.underscore rescue nil
    end
    name
  end

  # Gets the current controller namespace
  def namespace
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    @controller_namespace = controller_name_segments.join('/').camelize
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end

  #load the permissions for the current user so that UI can be manipulated
  def load_permissions
    @current_permissions = nil
    begin
      @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
    rescue
    end
  end

  def store_location
    session[:return_to] = request.fullpath if request.get? and controller_name != "user_sessions" and controller_name != "sessions"
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
  end

  private

  def after_sign_in_path_for(resource)
    home_path
  end
end
