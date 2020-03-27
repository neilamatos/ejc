class Admin::PessoasController < ApplicationController
  load_and_authorize_resource :class => 'Pessoa'
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]

  # GET /admin/pessoas
  # GET /admin/pessoas.json
  def index
    @q = Pessoa.order("nome ASC").search(params[:q])
    if params[:q]
      session[:search] = params[:q]
    end

    @pessoas = @q.result
    @total_registros = @q.result.count

    get_dependencies
  end

  def limpar_filtros
    session[:search] = []
    redirect_to admin_pessoas_path
  end


  # GET /admin/pessoas/1
  # GET /admin/pessoas/1.json
  def show

  end

  # GET /admin/pessoas/new
  def new
    @pessoa = Pessoa.new
    get_dependencies
  end

  # GET /admin/pessoas/1/edit
  def edit
    get_dependencies
  end

  # POST /admin/pessoas
  # POST /admin/pessoas.json
  def create
    @pessoa = Pessoa.new(pessoa_params)
    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to new_admin_pessoa_servico_path(@pessoa), notice: 'Pessoa foi criada com sucesso.' }
        format.json { render action: 'show', status: :created, location: @pessoa }
      else
        get_dependencies
        format.html { render action: 'new' }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pessoas/1
  # PATCH/PUT /admin/pessoas/1.json
  def update
    respond_to do |format|
      if @pessoa.update(pessoa_params)
        format.html { redirect_to admin_pessoas_path, notice: 'Pessoa foi atualizada com sucesso.' }
        format.json { head :no_content }
      else
        get_dependencies
        format.html { render action: 'edit' }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pessoas/1
  # DELETE /admin/pessoas/1.json
  def destroy
    @pessoa.destroy
    respond_to do |format|
      format.html { redirect_to admin_pessoas_url, notice: 'Pessoa foi deletada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end

    def get_dependencies
      @encontros = Encontro.order("descricao ASC").all.collect {|e| [e.descricao, e.id]}
      @tipos = Tipo.order("descricao ASC").all.collect {|t| [t.descricao, t.id]}
      @circulos = Circulo.order("descricao ASC").all.collect {|c| [c.descricao, c.id]}
      @habilidades = Habilidade.order("descricao ASC").all.collect {|h| [h.descricao, h.id]}
      @equipes = Equipe.order("descricao ASC").all.collect {|e| [e.descricao, e.id]}
      @equipes_funcoes = EquipeFuncao.order("descricao ASC").all.collect {|e| [e.descricao, e.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pessoa_params
      params.require(:pessoa).permit(:nome, :data_nasc, :encontro_id, :circulo_id,
        :tipo_id, :endereco, :bairro, :telefone_1, :telefone_2,
        equipe_ids: [],
        habilidade_ids: [])
    end
end
