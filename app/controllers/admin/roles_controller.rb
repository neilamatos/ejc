class Admin::RolesController < ApplicationController
  load_and_authorize_resource :class => 'Role'
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  #before_action :verify_system_roles, only: [:new, :edit, :create, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @q = Role.order("nome ASC").search(params[:q])
    @roles = @q.result.page(params[:page])
    @total_registros = @q.result.count
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
    @permissions = Permission.order("subject_class ASC, action ASC").all.collect { |p| [p, p.id]}
    @role_permissions = @role.permissions.collect{ |p| [p, p.id] }
  end

  # GET /roles/1/edit
  def edit
    @role_permissions = @role.permissions.collect{ |p| [p, p.id] }
    @permissions = Permission.order("subject_class ASC, action ASC")
    if @role_permissions.length > 0
      @permissions = @permissions.where("id NOT IN (?)", @role.permissions.collect{ |p| p.id })
    end
    @permissions = @permissions.collect { |p| [p, p.id]}
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        @role.set_permissions(params[:permissions]) if params[:permissions]

        format.html { redirect_to admin_role_path(@role), notice: 'Papel foi criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @role }
      else
        permissions_from_params(params[:permissions])

        format.html { render action: 'new' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        @role.permissions = []
        @role.set_permissions(params[:permissions]) if params[:permissions]

        format.html { redirect_to admin_role_path(@role), notice: 'Papel foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        permissions_from_params(params[:permissions])

        format.html { render action: 'edit' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_url }
      format.json { head :no_content }
    end
  end

  private
    def permissions_from_params(permissions_params)
      permissions_attrs = []
      if !permissions_params.blank?
        permissions_params.each do |permission_id|
          permissions_attrs << Permission.find(permission_id)
        end
      end

      @role_permissions = permissions_attrs.collect{ |p| [p, p.id] }
      @permissions = Permission.order("subject_class ASC, action ASC")
      if @role_permissions.length > 0
        @permissions = @permissions.where("id NOT IN (?)", permissions_attrs.collect{ |p| p.id })
      end
      @permissions = @permissions.collect { |p| [p, p.id]}
    end

    # Não é possível remover as roles do sistema (SuperAdmin, Aluno, Assistente Social e Diretoria de Assistencia Estudantil)
    def verify_system_roles
      if @role.nome == "SuperAdmin" || @role.nome == "Aluno" || @role.nome == "Assistente Social" || @role.nome == "Diretoria de Assistência Estudantil"
        render :file => 'public/404.html', status: 404 and return
        return
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:nome, :permissions_attributes, :uo_dependent)
    end
end
