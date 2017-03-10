class Admin::UsersController < ApplicationController
  load_and_authorize_resource class: 'User'
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  skip_authorize_resource only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :confirm_user]

  # GET /users
  # GET /users.json
  def index
    if current_user.local_access?
      @uos = {current_user.uo.nome => current_user.uo.id}

      if !params[:q].blank? && !params[:q][:uo_id_eq].blank?
        if params[:q][:uo_id_eq].to_i != current_user.uo_id
          params[:q][:uo_id_eq] = -1
        end
      end

      @q = User.where("uo_id = ?", current_user.uo_id).order("nome ASC").search(params[:q])
    else
      @uos = Uo.order("nome ASC").all.collect {|o| [o.nome, o.id]}

      @q = User.order("nome ASC").search(params[:q])
    end

    @users = @q.result.page(params[:page])
    @total_registros = @q.result.count
    @roles = Role.order("nome ASC").collect{ |r| [r.nome, r.id]}
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    if current_user.local_access?
      @uos = {current_user.uo.nome => current_user.uo.id}
    else
      @uos = Uo.order("nome ASC").all.collect {|uo| [uo.nome, uo.id]}
    end
    @roles = Role.order("nome ASC").all.collect { |role| [role.nome, role.id] }
  end

  # GET /users/1/edit
  def edit
    if unauthorized_access(!current_user.nil? && (current_user.id == @user.id || can?(:edit, "User".constantize)))
      return
    end

    if (@user.super_admin? && !current_user.super_admin?)
      return unauthorized_access(false)
    end

    if current_user.local_access?
      @uos = {current_user.uo.nome => current_user.uo.id}
    else
      @uos = Uo.order("nome ASC").all.collect {|uo| [uo.nome, uo.id]}
    end
    @roles = Role.order("nome ASC").all.collect { |role| [role.nome, role.id] }
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    if current_user.local_access?
      @user.uo_id = current_user.uo_id
    end

    respond_to do |format|
      @user.password_string = @user.password

      if verify_super_admin(@user) && @user.save
        format.html { redirect_to admin_user_path(@user), notice: 'Usuário foi criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        if !@user.errors.blank? && !@user.errors[:username].blank?
          @user.errors[:email] = @user.errors[:username]
        end

        if current_user.local_access?
          @uos = {current_user.uo.nome => current_user.uo.id}
        else
          @uos = Uo.order("nome ASC").all.collect {|uo| [uo.nome, uo.id]}
        end
        @roles = Role.order("nome ASC").all.collect { |role| [role.nome, role.id] }
        if !verify_super_admin(@user)
          flash.now[:error] = "Apenas um usuário com papel de SuperAdmin pode criar outro usuário SuperAdmin"
        end
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if (params[:user][:password].blank?)
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if unauthorized_access(!current_user.nil? && (current_user.id == @user.id || can?(:edit, "User".constantize)))
      return
    end

    if (@user.super_admin? && !current_user.super_admin?)
      return unauthorized_access(false)
    end

    user_redirect = admin_user_path(@user)
    redirect_options = { notice: 'Usuário foi atualizado com sucesso.' }

    respond_to do |format|
      @user.password_string = @user.password
      if verify_super_admin(@user) && @user.update(params[:user])
        if current_user.id == @user.id
          flash[:notice] = 'Usuário foi atualizado com sucesso. Para ter acesso ao sistema, é preciso se logar novamente com seus dados de acesso atualizados.'
          sign_out_and_redirect(@user)
          return
        end
        format.html { redirect_to user_redirect, redirect_options }
        format.json { head :no_content }
      else
        if current_user.local_access?
          @uos = {current_user.uo.nome => current_user.uo.id}
        else
          @uos = Uo.order("nome ASC").all.collect {|uo| [uo.nome, uo.id]}
        end
        @roles = Role.order("nome ASC").all.collect { |role| [role.nome, role.id] }
        if !verify_super_admin(@user)
          flash.now[:error] = "Apenas um usuário com papel de SuperAdmin pode criar outro usuário SuperAdmin"
        end
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    deleted = false
    # Não é possível deletar o último super admin
    if @user.can_delete?(current_user)
      @user.destroy
      deleted = true
    end

    respond_to do |format|
      if deleted
        format.html { redirect_to admin_users_url, notice: "Usuário deletado com sucesso!" }
      else
        format.html { redirect_to admin_users_url, alert: "Impossível deletar o último SuperAdmin do sistema ou usuário de um aluno!" }
      end
      format.json { head :no_content }
    end
  end

  # def confirm
  #   if (!@user.confirmed?)
  #     @user.confirm!
  #   end

  #   redirect_to admin_users_url, notice: "Usuário confirmado com sucesso!"
  # end

  private
    #Retorna true quando puder criar o super admin ou falso caso contrario
    def verify_super_admin(user)
      if user.role.blank? || user.role.nome != "SuperAdmin"
        return true
      end

      if current_user.role.nome == "SuperAdmin"
        return true
      end

      return false
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])

      return if unauthorized_local_access(@user.uo_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nome, :email, :password, :telefone, :password_confirmation, :uo_id, :role_id)
    end
end
