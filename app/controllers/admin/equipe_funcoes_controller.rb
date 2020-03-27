class Admin::EquipeFuncoesController < ApplicationController
  load_and_authorize_resource :class => 'EquipeFuncao'
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  before_action :set_equipe_funcao, only: [:show, :edit, :update, :destroy]

  # GET /admin/equipe_funcoes
  # GET /admin/equipe_funcoes.json
  def index
    @q = EquipeFuncao.joins(:equipe).order('equipes.descricao').search(params[:q])
    @equipe_funcoes = @q.result
    @total_registros = @q.result.count
    get_dependencies
  end

  # GET /admin/equipe_funcoes/1
  # GET /admin/equipe_funcoes/1.json
  def show

  end

  # GET /admin/equipe_funcoes/new
  def new
    @equipe_funcao = EquipeFuncao.new
    get_dependencies
  end

  # GET /admin/equipe_funcoes/1/edit
  def edit
    get_dependencies
  end

  # POST /admin/equipe_funcoes
  # POST /admin/equipe_funcoes.json
  def create
    @equipe_funcao = EquipeFuncao.new(equipe_funcao_params)
    respond_to do |format|
      if @equipe_funcao.save
        format.html { redirect_to admin_equipe_funcoes_path, notice: 'Equipe foi criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @equipe_funcao }
      else
        get_dependencies
        format.html { render action: 'new' }
        format.json { render json: @equipe_funcao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/equipe_funcoes/1
  # PATCH/PUT /admin/equipe_funcoes/1.json
  def update
    respond_to do |format|
      if @equipe_funcao.update(equipe_funcao_params)
        format.html { redirect_to admin_equipe_funcoes_path, notice: 'Equipe foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        get_dependencies
        format.html { render action: 'edit' }
        format.json { render json: @equipe_funcao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/equipe_funcoes/1
  # DELETE /admin/equipe_funcoes/1.json
  def destroy
    @equipe_funcao.destroy
    respond_to do |format|
      format.html { redirect_to admin_equipe_funcoes_url, notice: 'Equipe foi deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipe_funcao
      @equipe_funcao = EquipeFuncao.find(params[:id])
    end

    def get_dependencies
      @equipes = Equipe.order("descricao ASC").all.collect {|t| [t.descricao, t.id]}
      @funcoes = Funcao.order("descricao ASC").all.collect {|t| [t.descricao, t.id]}
      @tipos = Tipo.order("descricao ASC").all.collect {|t| [t.descricao, t.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipe_funcao_params
      params.require(:equipe_funcao).permit(:equipe_id, :funcao_id, :tipo_id, :minimo, :maximo)
    end
end
